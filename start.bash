#!/bin/bash

bash main/updater.bash 1>/dev/null 2>> logs/updater_err_log.txt &

lastpid=$!
echo $lastpid > main/pid
