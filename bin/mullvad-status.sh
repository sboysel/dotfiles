#!/usr/bin/bash
STATUS=$(mullvad status -v) 

if [ $(echo $STATUS | awk '{ print $1 }') = "Connected" ]; then
    RETURN="{\"text\": \"\", \"tooltip\": \"$STATUS\", \"class\": \"connected\"}" 
else
    RETURN="{\"text\": \"\", \"tooltip\": \"$STATUS\", \"class\": \"disconnected\"}"
fi

echo $RETURN | jq --unbuffered --compact-output 
