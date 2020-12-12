#!/bin/bash

# making sure we start duif

#jq < /home/pi/processes.json .duif_discord_bot.online=true > temp.json
#mv temp.json /home/pi/processes.json


# put every pid back to 0, that way whenever we first start this,
# every process that is supposed to be running wil start again (bc it will still be "online": true)
sed -i 's/\("pid":\) [0-9]\+/\1 0/g' main/processes.json

prcs="../main/processes.json"

# start the infinity loop

cd applications/

while true; do

	for dir in $(ls); do
		if [[ $(jq < $prcs .$dir) != "null" ]];then # directory inside applications exists in the json

# should be online
			if [[ $(jq < $prcs .${dir}.active) == "true" ]];then

				if [[ $(jq < $prcs .${dir}.pid) -eq 0 ]];then
	# needs to be started
					startfile=$(jq < $prcs .${dir}.startfile) # the file that needs to be ran
					cd $dir
					python3 ${startfile:1:-1} 1>>../logs/log_${dir} 2>> ../logs/log_${dir}_err & # startfile needs the surrounding quotes to be deleted
					last_pid=$! # this is the process id
					cd ..
					# adjust json
					replacement=$(echo "."${dir}".pid="$last_pid)
					jq < $prcs ${replacement} > temp.json
					mv temp.json $prcs
				fi

# should be offline
			elif [[ $(jq < $prcs .${dir}.active) == "false" ]];then

				if [[ ! $(jq < $prcs .${dir}.pid) -eq 0 ]];then
	# needs to be stopped
					kill $(jq < $prcs .${dir}.pid) # kill process
					# adjust json
					replacement=$(echo "."${dir}".pid=0")
					jq < $prcs ${replacement} > temp.json
                                        mv temp.json $prcs
				fi
			fi
		fi
	done
	sleep 5
done
