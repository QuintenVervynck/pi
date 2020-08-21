
sudo apt update

mkdir projects

# install python and pip
sudo apt install python3
sudo apt install python3-pip

# install python modules
pip3 install -U discord.py
pip3 install -U selenium
pip3 install -U spotipy
pip3 install -U webdriver_manager

# install chromium-chromedriver (used by the webdriver_manager)
# https://ivanderevianko.com/2020/01/selenium-chromedriver-for-raspberrypi
# path: /usr/lib/chromium-browser/chromedriver
sudo apt-get install chromium-chromedriver
