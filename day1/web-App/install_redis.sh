#!/bin/bash
sudo su
sudo apt update -y
cd /tmp/
sudo apt install redis-server -y
sudo apt install git -y
sudo rm /etc/redis/redis.conf
git clone https://github.com/kanumuruwe45/test-repo.git
cd test-repo/
sudo cp redis.conf /etc/redis/
sudo service redis-server start
sudo service redis restart
sudo apt update -y