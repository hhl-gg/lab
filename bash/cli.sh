#!/bin/bash

# exit shell when a command fails
# set -e
# enable command traces
# set -x

repeat() {
    for ((i=0;i<$1;i++)); do
        echo "$2"
    done
}

# parse args
while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -c|--count)
    COUNT="$2"
    shift
    ;;
    -p|--phrase)
    PHRASE="$2"
    shift
    ;;
esac
shift
done

repeat $COUNT $PHRASE