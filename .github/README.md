# dotfiles

![GPLv3](https://img.shields.io/badge/license-GPL3-brightgreen)

My dotfiles that I manage with [yadm](https://yadm.io/).

## Screenshots

![](../.screenshots/mba/screen0.png?raw=true)
![](../.screenshots/mba/screen1.png?raw=true)

More screenshots in [.screenshots](../.screenshots) directory.

## Installation

```
yadm clone https://github.com/sboysel/dotfiles.git
yadm status
```

## Workflow

Keep configs common to all machines in `main`, make branches for different 
systems (e.g. `mba`, `thinkpad`).

Common config change (i.e. `main`)

```
yadm checkout main
yadm pull main
yadm add path/to/file
yadm commit -m "[app] change"
yadm push -u origin main
```

System-specific config change (e.g. `mba`)

```
yadm checkout mba
yadm fetch
yadm rebase main
yadm add path/to/file
yadm commit -m "[app] change"
yadm push -u origin mba
```

**(important)** Revert back to `main` and apply the changes from the system specific branch

```
yadm checkout main
yadm merge --no-ff mba
yadm reset HEAD~1
```

## Misc

List of explicitly installed packages
```
yay -Qe > .pkglist
```

## License

[GNU GPLv3](https://choosealicense.com/licenses/gpl-3.0/)
