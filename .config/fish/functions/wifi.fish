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
