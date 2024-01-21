function rmcache --description "Clears $HOME/.cache"
    set -l BEFORE (sudo du -sh $HOME/.cache 2>/dev/null)
    echo -e "before:\t$BEFORE"
    sudo rm -rf $HOME/.cache/*
    set -l AFTER (sudo du -sh $HOME/.cache 2>/dev/null)
    echo -e "after:\t$AFTER"
end
