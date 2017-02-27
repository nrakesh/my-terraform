#!/usr/bin/env bash

LOG_DIR="/tmp"
LOG_FILE="${LOG_DIR}/build.log"

exec 1>>${LOG_FILE}
exec 2>>${LOG_FILE}

sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
docker info
