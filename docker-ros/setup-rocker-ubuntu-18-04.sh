# Ensure docker and cuda drivers are installed first (refer to other two bash scripts)

# Install rocker: https://github.com/osrf/rocker
# ... and the off-your-rocker extension: https://github.com/sloretz/off-your-rocker

sudo apt-get install python3-rocker
pip install rocker

# st-up venv
sudo apt-get install python3-venv
mkdir -p ./rocker_venv
python3 -m venv ./rocker_venv
# install rocker and testing utilities into venv (make sure it's activated first)
. ./rocker_venv/bin/activate
cd ./rocker_venv
pip install git+https://github.com/osrf/rocker.git
pip install nose
pip install coverage

nosetests-3.4 --with-coverage --cover-package rocker