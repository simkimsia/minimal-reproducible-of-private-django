FROM gitpod/workspace-postgres

# default user is gitpod
# Run this url https://gitpod.io/#https://github.com/oppoin/eno-a3-django/tree/feature/1704

# apt update
RUN sudo apt-get update

# Install Redis.
RUN sudo apt-get install -y redis-server

# Install Dropbear SSH server for chisel to work
RUN sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq dropbear

# remove lists and tmp
RUN sudo rm -rf /var/lib/apt/lists/* /tmp/*

# apt clean
RUN sudo apt-get clean


# ENTRYPOINT doesn't work in gitpod dockerfiles
# ENV DATABASE_URL="postgresql://gitpod@localhost/postgres" is the most impt
# but we load this via init in the .gitpod.yml Python task

# need to run as root else curl and install won't work
USER root

# This runs thru the installer https://github.com/jpillora/installer
# and caching may be an issue https://github.com/jpillora/installer/issues/9
RUN curl https://i.jpillora.com/chisel! | bash

# need to switch back to gitpod
USER gitpod


