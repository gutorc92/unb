#!/bin/bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y python-pip
pip install virtualenv
pip install virtualwrapper

if [ -a /usr/bin/python3.5 ]
then
	mkvirtualenv -p /urs/bin/python3.5/ web
fi
pip install -r requirements.txt
pip install -r requirements-dev.txt
