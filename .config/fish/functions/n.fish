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
