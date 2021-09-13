#!/usr/bin/bash
STATUS=$(mullvad status | awk '{ print $3 }') 

if [ $STATUS = "Connected" ]; then
    mullvad disconnect
else
    mullvad connect
fi

