sudo apt update

# install python and pip
sudo apt install python3
sudo apt install python3-pip
# install python modules
pip3 install -U discord.py
pip3 install -U selenium
pip3 install webdriver_manager

# install google-chrome (used by the webdriver_manager)
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
