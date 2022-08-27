# dotfiles

![GPLv3](https://img.shields.io/badge/license-GPL3-brightgreen)

My dotfiles that I manage with [yadm](https://yadm.io/).

## Screenshot

![](../.screenshots/thinkpad/screen1.png?raw=true)
![](../.screenshots/thinkpad/screen2.png?raw=true)

More screenshots in [.screenshots](../.screenshots) directory.

## Installation

```
yadm clone https://github.com/sboysel/dotfiles.git
yadm status
yadm bootstrap
```

## Workflow

```
vim ~/.vimrc
yadm add ~/.vimrc
yadm commit
yadm push
```

## Misc

List of explicitly installed packages
```
yay -Qe > .pkglist
```

## License

[GNU GPLv3](https://choosealicense.com/licenses/gpl-3.0/)
