#!/usr/bin/env python
import argparse
import json
import re
import subprocess
import sys


LIGHT_MON = 'sysfs/backlight/intel_backlight'
LIGHT_KBD = 'sysfs/leds/tpacpi::kbd_backlight'

def main():
    """
    """

    parser = argparse.ArgumentParser(description="A tool with multiple subcommands.")
    subparsers = parser.add_subparsers(dest='command')

    # volume
    volume_parser = subparsers.add_parser('volume', help='volume osd')
    volume_parser.add_argument("action", type=str, help='[mute/inc/dec]')

    # brightness 
    brightness_parser = subparsers.add_parser('brightness', help='brightness osd')
    brightness_parser.add_argument("action", type=str, nargs='?', help='[inc/dec]')
    brightness_parser.add_argument('-k', '--kbd', action='store_true', help='keyboard backlight')

    # parse args
    args = parser.parse_args()

    # init notification
    n = Notify()
    
    if is_active():
        n.dismiss()

    # process subcommands    
    if args.command == 'volume':
        if args.action == 'mute':
            subprocess.run(['wpctl', 'set-mute', '@DEFAULT_SINK@', 'toggle'])
        elif args.action == 'inc':
            subprocess.run(['wpctl', 'set-volume', '@DEFAULT_SINK@', '0.1+'])
        else:
            subprocess.run(['wpctl', 'set-volume', '@DEFAULT_SINK@', '0.1-'])

        cmd = volume()
        n.run(cmd)

    elif args.command == 'brightness':
        if args.kbd:
            b = capture(['light', '-s', LIGHT_KBD, '-G'])
            b = float(b)
            print(b)
            if b > 0:
                b = 0                
            else:
                b = 100
            subprocess.run(['light', '-s', LIGHT_KBD, '-S', str(b)])
            cmd = brightness_kbd()

        else:
            cmd = brightness_mon()
            if args.action == 'inc':
                subprocess.run(['light', '-s', LIGHT_MON, '-A', '10'])
            elif args.action == 'dec':
                subprocess.run(['light', '-s', LIGHT_MON, '-U', '10'])
                
        n.run(cmd)

    else:
        n.dismiss()
        # reload config
        n.reload()
        # run
        components = {
            'clock': clock(),
            'battery': battery(),
            'volume': volume(),
        }
        for c in reversed(components.values()):
            n.run(c)

    sys.exit(0)


class Notify:
    def __init__(self, cmd=['notify-send', '-t', '5000']):
        self.cmd = cmd

    def run(self, cmd):
        subprocess.run(self.cmd + cmd)
        
    def dismiss(self):
        subprocess.run(['makoctl', 'dismiss', '-a'])

    def reload(self):    
        subprocess.run(['makoctl', 'reload'])


def battery():
    """
    """
    b = capture(['acpi', '-b'])
    b = float(b)
    if b <= 80:
        cmd = ['-a', 'osd-lt80']
    else:
        cmd = ['-a', 'osd-gt80']
    cmd.extend(['-h', f'int:value:{b}'])
    cmd.append(f'󰁹 {b}%')
    return cmd, b

def clock():
    cmd = []
    cmd.extend(['-a', 'osd'])
    cmd.append(f" {capture(['date'])}")
    return cmd

def volume():
    output = capture(['wpctl', 'get-volume', '@DEFAULT_AUDIO_SINK@']).split()
    vol = int(float(output[1]) * 100)
    if len(output) == 3:
        text = f'  {vol}%'
    else:
        text = f'  {vol}%'    
    if vol <= 80:
        cmd = ['-a', 'osd-lt80']
    else:
        cmd = ['-a', 'osd-gt80']
    cmd.extend(['-h', f'int:value:{vol}'])
    cmd.append(text)
    return cmd


def brightness_mon():
    """
    """
    b = capture(['light', '-s', LIGHT_MON])
    b = float(b)
    if b <= 80:
        cmd = ['-a', 'osd-lt80']
    else:
        cmd = ['-a', 'osd-gt80']
    cmd.extend(['-h', f'int:value:{b}'])
    cmd.append(f'󰃞  {b}')
    return cmd

def brightness_kbd():
    """
    """
    b = capture(['light', '-s', LIGHT_KBD])
    b = float(b)
    if b <= 80:
        cmd = ['-a', 'osd-lt80']
    else:
        cmd = ['-a', 'osd-gt80']
    cmd.extend(['-h', f'int:value:{b}'])
    cmd.append(f' ')
    return cmd

def capture(cmd):
    """
    """
    try:
        result = subprocess.run(cmd, capture_output=True, text=True)
        output = result.stdout.strip()
        return output
    except subprocess.CalledProcessError:
        return None


def extract_number_from_percentage(string: str) -> int:
    """
    """
    match = re.search(r'(\d+(?:\.\d+)?)%', string)
    if match:
        return int(match.group(1))
    return None        

def is_active():
    output = json.loads(capture(['makoctl', 'list']))
    data = output['data'][0]
    return len(data) > 0


if __name__ == '__main__':
    main()
