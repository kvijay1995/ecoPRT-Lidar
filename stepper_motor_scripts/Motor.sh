#!/bin/bash
PATH="/sys/class/gpio"
SLEEP="/bin/sleep"
echo 60 > $PATH/export
echo out > $PATH/gpio60/direction
echo ON
while true
do
    echo 1 > $PATH/gpio60/value
    $SLEEP 0.15
    echo 0 > $PATH/gpio60/value
    $SLEEP 0.15
done
