#!/bin/bash

kill $(cat main/pid)

echo "not active" > main/pid
