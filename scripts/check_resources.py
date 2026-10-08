"""Validate the four original school Word documents using the standard library."""
import hashlib
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
WORD_RESOURCES = {
    '上海电力大学本科生毕业设计（论文）格式示范文本.doc':
        '682978def76fb275f269355ea178fbbc06bd8ba1275d49d286bd93f5e45904ff',
    '上海电力大学毕业设计（论文）封面 .doc':
        'b53135a93f28093dd85164f4126daa4155c5d29039614ac33e841b9cf0cd9013',
    '上海电力大学毕业设计（论文）原创性及使用授权声明.doc':
        'df4c2d2b90d0b3effb2d704a3c920a4fef2f5e8117850b411a7566302877beb8',
    '上海电力大学硕士（博士）学位论文范本 （试行）.doc':
        '70259a375aaa283debebe4c945875d7e4b582ba082daaf1e1a0d7af0843414ca',
}


def check_resources():
    for filename, expected in WORD_RESOURCES.items():
        path = ROOT / 'resources' / filename
        data = path.read_bytes()
        if not data.startswith(bytes.fromhex('d0cf11e0a1b11ae1')) or 'WordDocument'.encode('utf-16le') not in data:
            raise ValueError(f'Not an original binary Word document: {path.relative_to(ROOT)}')
        if hashlib.sha256(data).hexdigest() != expected:
            raise ValueError(f'Word resource changed; review the new source before updating its checksum: {path.relative_to(ROOT)}')


if __name__ == '__main__':
    check_resources()
    print('PASS four original Word resources: format and SHA-256')
