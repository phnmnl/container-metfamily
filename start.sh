#!/bin/sh

# Make sure to add the following entry in /etc/default/grub:
#GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"
# docker daemon --storage-driver=overlay

# Prepare docker
docker info
docker pull ubuntu

# Build docker
docker build --rm=true --cpu-shares=8 --cpuset-cpus="0-7" --cpuset-mems="0" --memory=8192g --tag=docker-metfam .

# Run docker
docker run --publish=9001:3838 --log-driver=syslog --volume=/vol/R/shiny/srv/shiny-server:/vol/R/shiny/srv/shiny-server:rw --cpu-shares=8 --cpuset-cpus="0-7" --cpuset-mems="0" --memory=8192g --name=docker-metfam-run -i -t -d docker-metfam

# Detach/Attach docker
# detach: CTRL-P + CTRL-Q
# docker attach docker-metfam-run

# manually:
#docker run -P -i -t --name=docker-metfam-run ubuntu /bin/bash
#docker ps -a
#docker commit docker-metfam-run
#docker rmi docker-metfam-run

