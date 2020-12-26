#!/bin/bash
sqlite3 ../main/processes.sqlite "
  create table prcs (
    name text unique not null primary key,
    active boolean not null,
    pid integer not null,
    start text not null
  );

 insert into prcs
    values ('hello', false, 0, 'main.py');

"
