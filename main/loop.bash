#!/bin/bash

# database
DB=$(find ./ -iname "processes.sqlite" -exec readlink -f {} \;)

# main table
MTB="prcs"

# go into the applications dir, since this is where all the programs are
cd applications/

# put every pid back to 0, that way whenever we first start this,
# every process that is supposed to be running wil start again (bc it will still be "online": true)
sqlite3 $DB "update $MTB set pid=0"


while true; do
  for dir in $(ls); do
    # find application dir in database
    exists=$(sqlite3 $DB
    if [[ $(sqlite3 $DB "select exists(select * from $MTB where name='$dir' limit 1);") -eq 1 ]];then
      # should it be active?
      pid=$(sqlite3 $DB "select pid from $MTB where name='$dir';")
      if [[ $(sqlite3 $DB "select active from $MTB where name='$dir';") -eq 1 ]];then
        # is it active?
        if [[ $pid -eq 0 ]];then
          # lets start it up
          startfile=$(sqlite3 $DB "select start from $MTB where name='$dir';")
          cd $dir
          python3 $startfile 1>> log_${dir} 2>> log_${dir}_err & # startfile needs the surrounding quotes to be deleted
          last_pid=$! # this is the process id
          cd ..
          # update database
          sqlite3 $DB "update $MTB set pid=$last_pid where name='$dir';"
        fi
      else
        # is it active?
        if [[ ! $pid -eq 0 ]];then
          # lets stop it
          kill $pid
          # update database
          sqlite3 $DB "update $MTB set pid=0 where name='$dir';"
        fi
      fi
    fi
  done
  sleep 3
done
