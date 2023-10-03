#!/bin/sh

test -L $1 && f=$(readlink -f $1)

MIME=$(file --mime-type $1 -b)

case $MIME in
    # text
    text/*) $EDITOR $1;;
    # json
    application/json) jq '.' $1 | less;;
    # images
    image/png) imv $1;;
    image/jpeg) imv $1;;
    image/svg+xml) display $1;;
    image/x-xcf) gimp $1;;
    # pdf
    application/pdf) zathura $1;;
    # video
    video/x-msvideo) mpv $1;;
    *) echo $1 $MIME;;
esac
