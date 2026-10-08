"""Render production pages and create a reproducible review inventory."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

from PIL import Image, ImageDraw
from pypdf import PdfReader

ROOT = Path(__file__).resolve().parents[1]
SOURCES = {
    'bachelor': 'templates/undergraduate-thesis/main.pdf',
    'master': 'templates/graduate-thesis/main.pdf',
    'master-professional': 'templates/graduate-thesis/main-professional.pdf',
    'doctor': 'templates/doctoral-thesis/main.pdf',
    'doctor-professional': 'templates/doctoral-thesis/main-professional.pdf',
    'manual': 'suepthesis-doc.pdf',
}
parser = argparse.ArgumentParser()
parser.add_argument('--dpi', type=int, default=120)
parser.add_argument('--only', choices=list(SOURCES), nargs='+',
                    help='Re-render selected production documents and retain other inventory entries.')
args = parser.parse_args()
out = ROOT / 'tmp/final-review'
out.mkdir(parents=True, exist_ok=True)
previous_path = out / 'inventory.json'
previous = json.loads(previous_path.read_text(encoding='utf-8')) if previous_path.exists() else {}
inventory = {name: value for name, value in previous.items() if name in SOURCES} if args.only else {}
for name, relative in SOURCES.items():
    if args.only and name not in args.only:
        continue
    pdf = ROOT / relative
    assert pdf.exists(), pdf
    reader = PdfReader(pdf)
    sha = hashlib.sha256(pdf.read_bytes()).hexdigest()
    directory = out / name / sha[:12]
    directory.mkdir(parents=True, exist_ok=True)
    prefix = directory / 'page'
    subprocess.run(['pdftoppm', '-r', str(args.dpi), '-png', str(pdf), str(prefix)],
                   check=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE)
    images = sorted(directory.glob('page-*.png'),
                    key=lambda p: int(p.stem.rsplit('-', 1)[1]))
    assert len(images) == len(reader.pages), (name, len(images), len(reader.pages))
    pages = []
    prior = previous.get(name, {})
    same_render = prior.get('sha256') == sha and prior.get('dpi') == args.dpi
    for i, image in enumerate(images):
        pages.append({'physical_page': i + 1, 'label': reader.page_labels[i],
                      'image': str(image.relative_to(ROOT)),
                      'first_text': (reader.pages[i].extract_text() or '')[:120],
                      'visual_review': 'pending'})
        if same_render and i < len(prior.get('pages', [])):
            old_page = prior['pages'][i]
            if old_page.get('physical_page') == i + 1:
                for key in ('visual_review', 'review_notes'):
                    if key in old_page:
                        pages[-1][key] = old_page[key]
    boards = []
    for offset in range(0, len(images), 4):
        sheet = Image.new('RGB', (1220, 1780), '#e4e4e4')
        draw = ImageDraw.Draw(sheet)
        for j, path in enumerate(images[offset:offset + 4]):
            page = Image.open(path).convert('RGB')
            page.thumbnail((595, 844))
            x, y = (j % 2) * 610 + 7, (j // 2) * 890 + 33
            draw.text((x, y - 23), f'{name}  physical {offset+j+1}  label {reader.page_labels[offset+j]}',
                      fill='black')
            sheet.paste(page, (x, y))
        board = directory / f'board-{offset // 4 + 1:02}.png'
        sheet.save(board)
        boards.append(str(board.relative_to(ROOT)))
    inventory[name] = {'pdf': relative, 'sha256': sha, 'page_count': len(reader.pages),
                       'dpi': args.dpi, 'pages': pages, 'boards': boards}
    print(f'RENDERED {name}: {len(reader.pages)} pages, {len(boards)} boards, {sha[:12]}')
(out / 'inventory.json').write_text(json.dumps(inventory, ensure_ascii=False, indent=2),
                                    encoding='utf-8')
print('Inventory created; rendering alone does not complete visual review.')
