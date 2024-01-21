#!/usr/bin/env bash
STATUS=$(mullvad status | awk '{ print $1 }') 

if [ $STATUS = "Connected" ]; then
    mullvad disconnect
else
    mullvad connect
fi

