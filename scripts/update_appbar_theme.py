from pathlib import Path
import re
root = Path(r'c:\Users\WIN-PC\uda_app')
changed = []
for path in sorted(root.glob('lib/screens/*.dart')):
    text = path.read_text(encoding='utf-8')
    lines = text.splitlines()
    out = []
    i = 0
    modified = False
    while i < len(lines):
        line = lines[i]
        if 'appBar: AppBar(' in line:
            out.append(line)
            i += 1
            depth = 0
            block = []
            while i < len(lines):
                l = lines[i]
                depth += l.count('(') - l.count(')')
                block.append(l)
                i += 1
                if depth <= -1:
                    break
            new_block = []
            has_bg = False
            has_fg = False
            for l in block:
                if 'backgroundColor:' in l and 'AppBar' not in l:
                    indent = l[:l.index('backgroundColor:')]
                    new_block.append(indent + 'backgroundColor: const Color(0xFFFFCC00),')
                    modified = True
                    has_bg = True
                    continue
                if 'foregroundColor:' in l:
                    indent = l[:l.index('foregroundColor:')]
                    new_block.append(indent + 'foregroundColor: Colors.black,')
                    modified = True
                    has_fg = True
                    continue
                if 'icon: const Icon(' in l and 'color:' in l and 'Color(0xFF1A5C2A)' in l:
                    new_block.append(l.replace('Color(0xFF1A5C2A)', 'Colors.black'))
                    modified = True
                    continue
                if 'color: Color(0xFF1A5C2A)' in l and 'TextStyle' in ''.join(new_block[-1:]):
                    new_block.append(l.replace('Color(0xFF1A5C2A)', 'Colors.black'))
                    modified = True
                    continue
                new_block.append(l)
            if not has_bg:
                inserted = False
                nb = []
                for l in new_block:
                    nb.append(l)
                    if not inserted and 'AppBar(' in l:
                        indent = l[:len(l) - len(l.lstrip())] + '  '
                        nb.append(indent + 'backgroundColor: const Color(0xFFFFCC00),')
                        nb.append(indent + 'foregroundColor: Colors.black,')
                        inserted = True
                new_block = nb
                modified = True
            elif not has_fg:
                nb = []
                for l in new_block:
                    nb.append(l)
                    if 'backgroundColor:' in l and 'AppBar' not in l:
                        indent = l[:l.index('backgroundColor:')]
                        nb.append(indent + 'foregroundColor: Colors.black,')
                        has_fg = True
                        modified = True
                new_block = nb
            out.extend(new_block)
        else:
            out.append(line)
            i += 1
    if modified:
        path.write_text('\n'.join(out) + '\n', encoding='utf-8')
        changed.append(str(path.relative_to(root)))
print('Updated files:', changed)
