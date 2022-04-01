#!/bin/bash
sudo su
sudo apt-get update -y
sudo apt-get install python3-venv -y
sudo apt-get update -y
sudo apt-get install python3-pip -y
sudo apt-get update -y
cd /tmp/
cd /tmp/application
pip3 install -r requirements.txt 
sudo apt-get install awscli -y
sudo apt-get update -y
export redisip=$(aws ec2 describe-instances --region us-west-2  --filters "Name=tag:Name,Values=database" "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
python3 app.py
