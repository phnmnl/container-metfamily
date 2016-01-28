#!/bin/sh

# Make sure to add the following entry in /etc/default/grub:
#GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"
# docker daemon --storage-driver=overlay

# Prepare docker
docker info
docker pull ubuntu

# Build docker
docker build --rm=true --cpu-shares=1 --cpuset-cpus="0-7" --cpuset-mems="0" --memory=8192g --tag=docker-shiny .

# Run docker
docker run --publish=3838:3838 --log-driver=syslog --volume=/vol:/vol:rw --cpuset-cpus="0-7" --cpuset-mems="0" --memory=8192g --name=docker-shiny-run -i -t -d docker-shiny

# Detach/Attach docker
# detach: CTRL-P + CTRL-Q
# docker attach docker-shiny-run

# manually:
#docker run -P -i -t --name=docker-shiny-run ubuntu /bin/bash
#docker ps -a
#docker commit docker-shiny-run
#docker rmi docker-shiny-run

