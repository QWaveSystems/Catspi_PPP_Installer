#!/bin/env bash

INTERVAL=60
DOUBLE_CHECK_WAIT=10
PING_TIMEOUT=9

function debug()
{
    echo $(date "+%Y/%m/%d - %H:%M:%S :") "$1"
}

function check_network()
{
    # Check the network is ready
    debug "Checking the network is ready..."

    for i in {1..600}; do
        NETWORK_OK=0

        debug "SIM Status:"
        atcom AT+CPIN? OK ERROR 10 | grep "CPIN: READY"
        SIM_READY=$?

        debug "Network Registeration Status:"
        # For super SIM
        atcom AT+CREG? OK ERROR 10 | grep "CREG: 0,5"
        NETWORK_REG=$?
        # For native SIM
        atcom AT+CREG? OK ERROR 10 | grep "CREG: 0,1"
        NETWORK_REG_2=$?
        # Combined network registeration status
        NETWORK_REG=$((NETWORK_REG+NETWORK_REG_2))

        if [[ $SIM_READY -eq 0 ]] && [[ $NETWORK_REG -le 1 ]]; then
            debug "Network is ready."
            NETWORK_OK=1
            return 0
            break
        else
            printf "?"
        fi
        sleep 2
    done
    return 1
}

if check_network -eq 0; then 
    debug "PPP chatscript is starting...";
    sudo pon;
else 
    debug "Network registeration is failed!";
fi 

while true; do
    # Checking cellular internet connection
    ping -q -c 1 -s 0 -w $PING_TIMEOUT -I ppp0 8.8.8.8 > /dev/null 2>&1
    PINGG=$?

    if [[ $PINGG -eq 0 ]]; then
        printf "."
    else
        printf "/"
        sleep $DOUBLE_CHECK_WAIT
	    # Checking cellular internet connection
        ping -q -c 1 -s 0 -w $PING_TIMEOUT -I ppp0 8.8.8.8 > /dev/null 2>&1
        PINGG=$?

        if [[ $PINGG -eq 0 ]]; then
            printf "+"
        else
	        debug "Connection is down, reconnecting..."
            if check_network -eq 0; then sleep 0.1; else debug "Network registeration is failed!"; fi
	        sudo pon
	    fi
    fi
	sleep $INTERVAL
done