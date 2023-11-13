if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_config theme choose catppuccin_mocha
end

### environment ###
set -gx LC_ALL en_US.UTF-8
set -gx LOCALE_ARCHIVE /usr/lib/locale/locale-archive

set -gx EDITOR /usr/bin/nvim
set -gx VISUAL /usr/bin/nvim
set -gx SUDO_EDITOR /usr/bin/nvim
set -gx SYSTEMD_EDITOR /usr/bin/nvim

set -gx WM /usr/bin/river

set -gx OPENER $HOME/bin/opener.sh

set -gx BG_COLOR "#446879"

set -gx XDG_CURRENT_DESKTOP sway
set -gx XDG_SESSION_TYPE wayland
set -gx MOZ_ENABLE_WAYLAND 1
set -gx WLR_NO_HARDWARE_CURSORS 1
set -gx QT_QPA_PLATFORM wayland

set -gx GPG_TTY $(tty)

set -gx GOPATH "$HOME/go"
set -gx GOBIN "$HOME/go/bin"
set -gx GOOS "linux"
set -gx GOARCH "amd64" 
# set -gx R_LIBS_USER "$HOME/.r"
set -gx JULIA_PROJECT '@.'
set -gx JULIA_NUM_THREADS 4
set -gx npm_config_prefix "$HOME/.local"
set -gx RANGER_LOAD_DEFAULT_RC FALSE
set -gx RUSTC_WRAPPER sccache
set -gx NIXPKGS_ALLOW_UNFREE 1

set -gx NOTES_REPO "$HOME/repos/notes"
set -gx OBSIDIAN_REPO "$HOME/doc/obsidian"
set -gx XDG_SCREENSHOTS_DIR "$HOME/img/screenshots"

# pdm
if test -n "$PYTHONPATH"
    set -x PYTHONPATH '/usr/lib/python3.10/site-packages/pdm/pep582' $PYTHONPATH
else
    set -x PYTHONPATH '/usr/lib/python3.10/site-packages/pdm/pep582'
end

### functions (aliases) ###

#
# shell
#

set fish_greeting

function fish_source
    source $HOME/.config/fish/config.fish
end

#
# working with files
#

function e --description "Alternative to `ls` (pretty, detailed)"
    /usr/bin/exa --icons --group-directories-first --time-style long-iso -lg $argv
end

function ls
    /usr/bin/ls --color -hlX $argv
end

function mime
  file --mime-type $argv -b
end

#
# package management
#

function yu --description "Update system"
    yay -Syyu $argv
end

function yss --description "Search packages"
    yay -Ss $argv
end

function ys --description "Install packages"
    yay -S $argv
end

function yqi --description "Information about installed package"
    yay -Si $argv
end 

function yql --description "Query files owned by installed package"
    yay -Ql $argv
end 

function yo --description "List orphaned packages"
    yay -Qtdq
end

function yc --description "Clean yay package cache"
    yay -Scc
end

function yd --description "Removed unneeded yay dependencies"
    yay -Yc
end

function ye --description "Show explicitly installed packages"
    yay -Qe
end

function ym --description "Show manually installed packages"
    yay -Qm
end

#
# maintenance
#

function rmcache --description "Clears $HOME/.cache"
    set BEFORE (sudo du -sh $HOME/.cache 2>/dev/null)
    echo -e "before:\t$BEFORE"
    sudo rm -rf $HOME/.cache/*
    set AFTER (sudo du -sh $HOME/.cache 2>/dev/null)
    echo -e "after:\t$AFTER"
end

function rmorph --description "Remove orphaned packages"
    sudo pacman -Rns (pacman -Qtdq)
end

function rmjourn --description "Vaccum systemd journal"
    sudo journalctl --vacuum-time=2weeks
end

function pkgdiff --description "changes in packages installed on system"
    yay -Qe | diff $HOME/.pkglist -
end

function nixpkgdiff --description "changes in Nix packages installed on system"
    nix-env -qa --installed "*" | diff $HOME/.nixpkglist -
end

#
# aliases
#

function hypr
  /usr/bin/Hyprland $argv
end

function hx
  /usr/bin/helix $argv
end

function cl
    /sbin/clear
end

# function todo
#     $GOBIN/ultralist $argv
# end

# function tl --description "ultralist list"
#     todo l
# end

# function ta --description "ultralist add [args]"
#     todo add $argv
# end

function todo --description "todo [add=/do=/done/all/edit]"

  set -l TODO $HOME/sync/todo/todo
  set -l DONE $HOME/sync/todo/done

  argparse 'a/add=' 'do=' 'done' 'all' 'e/edit' -- $argv
  
  if set -q _flag_add
    echo '[ ] '$_flag_add >> $TODO
  else if set -q _flag_do
    sed $_flag_do's/\[ \]/\[x\]/' $TODO >> $DONE
    sed -i $_flag_do'd' $TODO
  else if set -q _flag_done
    cat -n $DONE
  else if set -q _flag_edit
    $EDITOR $TODO
  else
    cat -n $TODO
  end

end

function ta
  todo --add $argv
end

function td
  todo --do $argv
end

function R
    /usr/bin/R --no-save $argv
end

function ptpython
    # python -m venv $HOME/.venv/ptpython
    # source $HOME/.venv/ptpython/bin/activate.fish
    # pip install -U pip ptpython
    source $HOME/.venv/ptpython/bin/activate.fish
    $HOME/.venv/ptpython/bin/ptpython
    deactivate
end

# function zathura
#     GDK_BACKEND=x11 /usr/bin/zathura $argv
# end

function tmuxp --description "tmuxp [profile name]"
  /usr/bin/tmuxp load $HOME/.config/tmuxp/$argv.yaml
end

## utilities

function slink --description "save URL to ~/sync/links"
  if set -q argv[1]
    echo $argv >> $HOME/sync/links
  else
    cat $HOME/sync/links
  end
end

# HTML to markdown
function curlmd --description "curlmd [url]"
  curl $argv | pandoc -f html -t markdown
end

# initialize empty project
function proj-init
  set WD (pwd)
  set PROJ_NAME $argv
  set PROJ_PATH "$WD/$PROJ_NAME"
  echo $PROJ_PATH
  mkdir -p $PROJ_PATH
  # source code
  mkdir -p $PROJ_PATH/src
  touch $PROJ_PATH/src/.gitignore
  # input
  mkdir -p $PROJ_PATH/input
  touch $PROJ_PATH/input/.gitignore
  # outputs
  mkdir -p $PROJ_PATH/output
  mkdir -p $PROJ_PATH/output/plots
  touch $PROJ_PATH/output/.gitignore
  touch $PROJ_PATH/output/plots/.gitignore
  # temp
  mkdir -p $PROJ_PATH/temp
  touch $PROJ_PATH/temp/.gitignore
  # doc
  mkdir -p $PROJ_PATH/doc
  mkdir -p $PROJ_PATH/doc/notebooks
  touch $PROJ_PATH/doc/.gitignore
  touch $PROJ_PATH/doc/notebooks/.gitignore
  # README
  echo "# $PROJ_NAME" >> $PROJ_PATH/README.md
  # venv
  python -m venv ~/.venv/$PROJ_NAME
  # envrc
  echo "source ~/.venv/$PROJ_NAME/bin/activate" >> $PROJ_PATH/.envrc 
  direnv allow $PROJ_PATH
  # git
  git init $PROJ_PATH
  gh repo create $PROJ_NAME --private
  cd $PROJ_PATH
  git remote add origin git@github.com:sboysel/$PROJ_NAME.git
  cd $WD
  # jupyter
  cd $PROJ_PATH
  pip install -U pip jupyterlab
  pip freeze | grep "jupyterlab==" >> requirements.txt
  # R
  echo ".Rproj.user/" >> $PROJ_PATH/.gitignore
  echo "renv/library" >> $PROJ_PATH/.gitignore
  echo "renv/sandbox" >> $PROJ_PATH/.gitignore
  echo ".Rhistory" >> $PROJ_PATH/.gitignore
  Rscript -e "install.packages('renv')"
  Rscript -e "renv::init()"
  Rscript -e "install.packages(c('here', 'fixest', 'gt', 'IRkernel', 'modelsummary', 'tidyverse'))"
  Rscript -e "renv::snapshot()"
  Rscript -e "IRkernel::installspec()"
  echo "# https://stackoverflow.com/a/71257658" >> $PROJ_PATH/doc/notebooks/.Rprofile
  echo "owd <- setwd('$PROJ_PATH')" >> $PROJ_PATH/doc/notebooks/.Rprofile
  echo "source('renv/activate.R')" >> $PROJ_PATH/doc/notebooks/.Rprofile
  echo "setwd(owd)" >> $PROJ_PATH/doc/notebooks/.Rprofile
  echo ".ipynb_checkpoints" >> $PROJ_PATH/doc/notebooks/.gitignore
  jupyter labextension install @techrah/text-shortcuts
  # print tree
  tree -L 2 $PROJ_PATH
end

# interactively commit changes to dotfiles
function dots --description "config management"
    set CURRENT_DIR (pwd)
    set CURRENT_BRANCH (yadm branch --show-current)
    cd $HOME
    read -l -P "==> show diff? [y/n]: " reply
    switch $reply
        case Y y
            yadm --no-pager diff origin/$CURRENT_BRANCH
        case '' N n
    end
    # iterate through uncommited changes, add, and commit
    echo ""
    echo "==> Unstaged changes"
    echo ""
    for i in (yadm status --porcelain | awk '{print $2}')
        yadm --no-pager diff $i
        read -l -P "==> add and commit? [y/n]: " reply
        switch $reply
            case Y y
                yadm add $i
                read -l -P "==> message: " message
                yadm commit -m $message
            case '' N n
                continue
        end
    end
    # update list of arch linux packages (yay)
    if test (pkgdiff | wc -l) -gt 0
        pkgdiff
        read -l -P "==> update $HOME/.pkglist? [y/n]: " reply
        switch $reply
            case Y y
                yay -Qe > $HOME/.pkglist
                yadm add $HOME/.pkglist
                yadm commit -m "[packages] bump"
            case '' N n
        end
    end
    # update list nix packages (nix-env)
    if test (nixpkgdiff | wc -l) -gt 0
        nixpkgdiff
        read -l -P "==> update $HOME/.nixpkglist? [y/n]: " reply
        switch $reply
            case Y y
                nix-env -qa --installed "*" > $HOME/.nixpkglist
                yadm add $HOME/.nixpkglist
                yadm commit -m "[nix-packages] bump"
            case '' N n
        end
    end
    # push the commited changes
    if test (yadm status -sb | grep 'ahead' | wc -l) -ge 1
        yadm log origin/$CURRENT_BRANCH..$CURRENT_BRANCH
        # TODO: rebase?
        read -l -P "==> rebase? [y/n]: " reply
        switch $reply
            case Y y
                set COMMITS_AHEAD (yadm rev-list origin/$CURRENT_BRANCH..$CURRENT_BRANCH | wc -l)
                yadm rebase -i HEAD~$COMMITS_AHEAD
            case '' N n
        end
        read -l -P "==> push? [y/n]: " reply
        switch $reply
            case Y y
                yadm push -u origin
            case '' N n
        end
    end
    cd $CURRENT_DIR
end

# notes utility
function n --description "n [title]"
    if not set -q argv[1]
        # search all notes for editing
        nvim (printf %s\n (find $NOTES_REPO -type f) | fzf)
    else
        set REGEX "*$argv*.md"
        set SEARCH_RESULTS (find $NOTES_REPO -type f -name $REGEX)
        echo $SEARCH_RESULTS
        if test (count $SEARCH_RESULTS) -gt 0
            # match title with existing notes
            nvim (printf %s\n $SEARCH_RESULTS | fzf)  
        else
            # new notes
            nvim $NOTES_REPO/(date +"%Y%m%d")_$argv.md
        end
    end
end

# # todo utility
# function todo --description "todo [edit|done] [n]"
#     if not set -q argv[1]
#         /usr/bin/mdcat $HOME/.todo
#     else if [ $argv[1] = "edit" ]
#         $EDITOR $HOME/.todo
#     else if [ $argv[1] = "done" ]
#         set N $argv[2]
#         /usr/bin/sed -i "s/$N\. \[ \]/$N\. \[x\]/g" $HOME/.todo
#         /usr/bin/mdcat $HOME/.todo
#     else
#         set N $argv[1]
#         set REGEX "$N s/$N. \[ \] //p"
#         set MSG (sed -n $REGEX $HOME/.todo)
#         $GOBIN/countdown 2s && /usr/bin/notify-send \
#                 -i $HOME/.local/share/pomo/icon.png \
#                 "TODO $N // pomodoro complete" $MSG \
#             && /usr/bin/paplay /usr/share/sounds/freedesktop/stereo/message.oga
#         echo "TODO $N // pomodoro complete // $MSG"
#     end
# end

# connect to wifi
# source: https://gist.github.com/guyzmo/146423d0cf7d3c0a46e10eeb66883905
function wifi --description "Combine nmcli with fzf to connect to wifi networks"
    set SSID ''
    set PASSWORD ''
    nmcli device wifi rescan > /dev/null
    # get SSID from list
    set SSID $(nmcli device wifi list | \
        tail -n +2 | \
        grep -v '^  *\B--\B' | \
        fzf -m | \
        sed 's/^ *\*//' | \
        awk '{print $2}')
    echo "SSID: $SSID"
    # user input password
    while true
        # read -l -s -P "password: " INPUT
        read -l -P "password: " INPUT
        if [ $INPUT != '' ]
            set PASSWORD $INPUT
            break
        else
            echo "ERROR: password cannot be empty"
        end
    end
    # connect
    nmcli device wifi connect $SSID password "$PASSWORD"
end

# crop images for wallpaper
function cropper
    set x_res (swaymsg -t get_outputs | jq '.[0].current_mode.width')
    set y_res (swaymsg -t get_outputs | jq '.[0].current_mode.height')
    set x_img (magick identify -format '%w' $argv[1])
    set y_img (magick identify -format '%h' $argv[1])
    if test $x_img -gt $x_res && test $y_img -gt $y_res
        magick convert -resize $x_res"x"$y_res"^" $argv[1] $argv[2] 
    end
end

### plugins ###
set fzf_fd_opts --hidden --exclude=.git --exclude=.cache

### hooks ###
# pyenv
pyenv init - | source

# direnv
set -gx DIRENV_LOG_FORMAT 
direnv hook fish | source

# starship prompt
starship init fish | source
