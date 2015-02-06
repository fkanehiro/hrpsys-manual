#!/bin/bash

set -x

sudo add-apt-repository -y ppa:hrg/daily
sudo apt-get update -qq
sudo apt-get install -qq -y python-pip graphviz pkg-config hrpsys-base
sudo pip install -r requires.txt

source ./build.sh
