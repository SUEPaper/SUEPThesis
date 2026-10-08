"""Source-only checks; no TeX, commercial fonts or third-party Python modules."""
import argparse
import ast
from pathlib import Path
import re

from check_resources import check_resources

ROOT = Path(__file__).resolve().parents[1]
TAG_PATTERN = r"v\d+\.\d+\.\d+(?:-[A-Za-z0-9]+(?:[.-][A-Za-z0-9]+)*)?"


def check_tag(tag: str) -> None:
    if not tag:
        return
    if not re.fullmatch(TAG_PATTERN, tag):
        raise ValueError("Release tag must be vMAJOR.MINOR.PATCH, optionally with a prerelease suffix.")
    source = (ROOT / "suepthesis.dtx").read_text(encoding="utf-8")
    version = re.search(r"\\ProvidesExplClass\{suepthesis\}\{[^}]+\}\{([^}]+)\}", source)
    if version is None or version[1] != tag[1:]:
        raise ValueError("Release tag must match the version in suepthesis.dtx.")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tag", default="")
    args = parser.parse_args()
    for path in (ROOT / "scripts").glob("*.py"):
        ast.parse(path.read_text(encoding="utf-8-sig"), filename=str(path))
    check_tag(args.tag)
    check_resources()
    # Copyable writing examples must not depend on specimen-only formatting.
    forbidden = re.compile(r'\\(?:ExplSyntaxOn|SUEPSample\w*|SUEPReferenceTOC|fontspec|ctexset|setmathfont|linebreak)\b|reference-(?:toc|bib-layout|sample)')
    for path in (ROOT / 'templates').rglob('*.tex'):
        if forbidden.search(path.read_text(encoding='utf-8')):
            raise ValueError(f'Implementation or specimen patch in writing example: {path.relative_to(ROOT)}')


if __name__ == "__main__":
    main()
