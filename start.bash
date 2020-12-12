#!/bin/bash

bash main/loop.bash 1>/dev/null 2>> logs/updater_err_log.txt &

lastpid=$!
echo $lastpid > main/pid
