#!/bin/bash

# Fetch the variables
. parm.txt

# function to get the current time formatted
currentTime()
{
  date +"%Y-%m-%d %H:%M:%S";
}

sudo docker service scale devops-dockerswarmvisualizer=0

#echo ---$(currentTime)---populate the volumes---
#to zip, use: sudo tar zcvf devops_dockerswarmvisualizer_volume.tar.gz /var/nfs/volumes/devops_dockerswarmvisualizer*
#sudo tar zxvf devops_dockerswarmvisualizer_volume.tar.gz -C /

echo ---$(currentTime)---create dockerswarmvisualizer service---
sudo docker service create -d \
--publish $DOCKERSWARMVISUALIZER_PORT:8080 \
--name devops-dockerswarmvisualizer \
--mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
--network $NETWORK_NAME \
--replicas 1 \
--constraint 'node.role == manager' \
$DOCKERSWARMVISUALIZER_IMAGE

sudo docker service scale devops-dockerswarmvisualizer=1