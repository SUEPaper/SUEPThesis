"""Package compiled examples, handbook and rebuildable sources without build debris."""
import argparse
import hashlib
from pathlib import Path
import re
import shutil
import zipfile

from check_source import check_tag

ROOT = Path(__file__).resolve().parents[1]
PDFS = {
    'bachelor': 'templates/undergraduate-thesis/main.pdf',
    'master-academic': 'templates/graduate-thesis/main.pdf',
    'master-professional': 'templates/graduate-thesis/main-professional.pdf',
    'doctor-academic': 'templates/doctoral-thesis/main.pdf',
    'doctor-professional': 'templates/doctoral-thesis/main-professional.pdf',
    'handbook': 'suepthesis-doc.pdf',
}


def source_files() -> list[Path]:
    # Explicit directory/extension allowlist: never collect arbitrary workspace files.
    files = [ROOT / name for name in (
        'README.md', 'LICENSE', 'Makefile', '.explcheckrc', '.gitignore',
        'suepthesis.dtx', 'suepthesis.ins', 'suepthesis.cls',
        'suepthesis-graduate.bst', 'suepthesis-doc.tex', 'suepthesis-doc.pdf',
    )]
    extensions = {
        'templates': {'.tex', '.bib', '.bst', '.md', '.png', '.jpg', '.jpeg'},
        'scripts': {'.ps1', '.py', '.sh', '.zsh'},
        '.github/workflows': {'.yml', '.yaml'},
        'resources': {'.doc', '.docx', '.md'},
    }
    for directory, allowed in extensions.items():
        files.extend(p for p in (ROOT / directory).rglob('*') if p.is_file()
                     and (p.suffix.lower() in allowed or p.name == 'latexmkrc'))
    # Include the generated class in each copyable thesis project.
    for directory in ('undergraduate-thesis', 'graduate-thesis', 'doctoral-thesis'):
        files.append(ROOT / 'templates' / directory / 'suepthesis.cls')
    for path in files:
        if not path.is_file():
            raise FileNotFoundError(f'Required release file missing: {path.relative_to(ROOT)}')
    return sorted(set(files))


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--tag', default='')
    parser.add_argument('--commit', default='local')
    args = parser.parse_args()
    check_tag(args.tag)
    if not re.fullmatch(r'[A-Za-z0-9-]{1,64}', args.commit):
        raise ValueError('Invalid build commit identifier.')
    version = args.tag or f'dev-{args.commit[:12]}'
    files = source_files()
    # Preflight all outputs before writing anything; existing packages are never mixed.
    for filename in PDFS.values():
        if not (ROOT / filename).is_file():
            raise FileNotFoundError(f'Compile first: {filename}')
    output = ROOT / 'dist'
    output.mkdir(exist_ok=True)
    if any(output.iterdir()):
        raise FileExistsError('dist must be empty before packaging; move earlier artifacts out first.')
    archive = output / f'SUEPThesis-{version}.zip'
    prefix = f'SUEPThesis-{version}'
    with zipfile.ZipFile(archive, 'w', compression=zipfile.ZIP_DEFLATED) as package:
        for path in files:
            package.write(path, f'{prefix}/{path.relative_to(ROOT).as_posix()}')
        package.writestr(f'{prefix}/BUILD.txt', f'version={version}\ncommit={args.commit}\n')
    for profile, filename in PDFS.items():
        shutil.copyfile(ROOT / filename, output / f'SUEPThesis-{version}-{profile}.pdf')
    checksums = ''.join(f'{hashlib.sha256(p.read_bytes()).hexdigest()}  {p.name}\n'
                        for p in sorted(output.iterdir()))
    (output / 'SHA256SUMS.txt').write_text(checksums, encoding='utf-8')
    print(f'PASS packaged {len(files)} source files, five examples, handbook and SHA256SUMS in {output}')


if __name__ == '__main__':
    main()
