sudo apt install postgresql libpq-dev -y
sudo apt-get install python3-dev
sudo pip install psycopg2


# sudo -u postgres psql
# CREATE DATABASE menu;
# \q
# sudo -u postgres psql postgres
# \password postgres


# Edit the PostgreSQL config file /etc/postgresql/9.6/main/postgresql.conf
# to uncomment the listen_addresses line and change its value from 'localhost' to '*'. Save and exit.
# sudo nano /etc/postgresql/11/main/postgresql.conf

# Edit the pg_hba config file /etc/postgresql/9.6/main/pg_hba.conf
# to change 127.0.0.1/32 to 0.0.0.0/0 for IPv4 and ::1/128 to ::/0 for IPv6. Save and exit.
# sudo nano /etc/postgresql/11/main/pg_hba.conf

# Restart the PostgreSQL service: sudo service postgresql restart.
