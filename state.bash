#!/bin/bash

if [[ $(cat main/pid) == "not active" ]];then
	echo "not active"
else
	echo "active"
fi
