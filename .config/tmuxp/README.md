
- https://gist.github.com/MohamedAlaa/2961058
- https://leanpub.com/the-tao-of-tmux/read
- https://github.com/tmux-python/tmuxp

```sh
yay -S tmuxp
mkdir -p ~/.config/tmuxp/
nvim ~/.config/tmuxp/default.yaml
```

add the following

```yaml
session_name: default
windows:
  - window_name: main
    layout: tiled
    shell_command_before:
      - cd ~
      - clear
  - window_name: btop
    layout: tiled
    shell_command_before:
      - cd ~
      - btop
  - window_name: tariffs
    layout: even-horizontal
    shell_command_before:
      - cd ~/repos/tariffs # run as a first command in all panes
    panes:
    - shell_command:
      - cmd: ranger
    - shell_command:
      - cmd: clear
```

launch session profile

```sh
tmuxp load ~/.config/tmuxp/default.yaml
```

reattach

```sh
tmux attach -t default
```
