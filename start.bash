#!/bin/bash

bash main/loop.bash 1> /dev/null 2>> ./logs/start &

lastpid=$!
echo $lastpid > main/pid
