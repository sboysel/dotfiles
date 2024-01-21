# interactively commit changes to dotfiles
function dots --description "dotfile workflow with yadm"
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
