#!/bin/bash

# making sure we start duif

jq < /home/pi/processes.json .duif_discord_bot.online=true > temp.json
mv temp.json /home/pi/processes.json


# put every pid back to 0, that way whenever we first start this,
# every process that is supposed to be running wil start again (bc it will still be "online": true)

sed -i 's/\("pid":\) [0-9]\+/\1 0/g' /home/pi/processes.json


# start the infinity loop

while true; do

	cd /home/pi/projects

	for dir in $(ls); do
		if [[ $(jq < /home/pi/processes.json .$dir) != "null" ]];then # exists

# should be online
			if [[ $(jq < /home/pi/processes.json .${dir}.online) == "true" ]];then
	# needs to be started
				if [[ $(jq < /home/pi/processes.json .${dir}.pid) -eq 0 ]];then
					startfile=$(jq < /home/pi/processes.json .${dir}.startfile) # the file that needs to be run
					cd $dir
					python3 ${startfile:1:-1} 1>> log1.txt 2>> log2.txt & # startfile needed to be formatted due to surrounding quotes
					last_pid=$! # this is the process id
					cd ..
					# adjust json
					replacement=$(echo "."${dir}".pid="$last_pid)
					jq < /home/pi/processes.json ${replacement} > /home/pi/temp.json
					mv /home/pi/temp.json /home/pi/processes.json
				fi
# should be offline
			elif [[ $(jq < /home/pi/processes.json .${dir}.online) == "false" ]];then
	# needs to be stopped
				if [[ ! $(jq < /home/pi/processes.json .${dir}.pid) -eq 0 ]];then
					kill $(jq < /home/pi/processes.json .${dir}.pid) # kill process
					# adjust json
					replacement=$(echo "."${dir}".pid=0")
					jq < /home/pi/processes.json ${replacement} > /home/pi/temp.json
                                        mv /home/pi/temp.json /home/pi/processes.json

				fi
			fi
		fi
	done
	sleep 20
done
