#!/usr/bin/bash
STATUS=$(mullvad status | awk '{ print $3 }') 

if [ $STATUS = "Connected" ]; then
    RETURN="{\"text\": \"\", \"class\": \"connected\"}" 
else
    RETURN="{\"text\": \"\", \"class\": \"disconnected\"}"
fi

echo $RETURN | jq --unbuffered --compact-output 
