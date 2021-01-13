#!/bin/bash

kill $(sqlite3 main/processes.sqlite "select pid from prcs where pid is not 0;" | tr '\n' ' ')
