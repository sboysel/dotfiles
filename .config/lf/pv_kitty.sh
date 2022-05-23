#!/usr/bin/env bash
file=$1
w=$2
h=$3
x=$4
y=$5

filetype="$( file -Lb --mime-type "$file")"

if [[ "$filetype" =~ ^image ]]; then
    kitty +icat --silent --transfer-mode file --place "${w}x${h}@${x}x${y}" "$file"
    exit 1
fi

if [[ "$filetype" =~ ^video ]]; then
    # vidthumb is from here:
    # https://raw.githubusercontent.com/duganchen/kitty-pistol-previewer/main/vidthumb
    kitty +icat --silent --transfer-mode file --place "${w}x${h}@${x}x${y}" "$(vidthumb "$file")"
    exit 1
fi

if [[ "$filetype" =~ pdf$ ]]; then
    kitty +icat --silent --transfer-mode file --place "${w}x${h}@${x}x${y}" "$(pdfthumb "$file")"
    exit 1
fi


pistol "$file"
