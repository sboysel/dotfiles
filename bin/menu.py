#!/usr/bin/env python
import os
import shlex
import subprocess
import sys

TERM = os.environ['TERM']
MENU = {
    # 'foo': {
    #     'a': 'echo hello, world!',
    #     'b': 'echo 2'
    # },
    'btop': f'{TERM} btop',
    'newsboat': f'{TERM} newsboat',
    'ssh': {
        'augiez': f'{TERM} ssh augiez'
    }
}

def main():
    """
    """

    d = MENU
    
    def _run(d: dict):
        menu = '\n'.join(d.keys())
        choice = subprocess.run(['tofi'], input=menu, text=True,capture_output=True)
        d = d[choice.stdout.strip()]
        # recurse into submenu
        if isinstance(d, dict):
            _run(d)
        # run choice if it's a command
        elif isinstance(d, str):
            cmd = shlex.split(d)
            subprocess.run(cmd)
        else:
            raise Exception(f'd is a {type(d)}')
        
    _run(d)

    sys.exit(0)


if __name__ == '__main__':
    main()
