FROM tomgeorge/base:latest
MAINTAINER Tom George<tg82490@gmail.com>
RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    ssh \
    sshpass \
    python && \
    apt-add-repository ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y ansible
# RUN useradd -Ums /bin/bash deploy
# RUN mkdir -p /usr/src/app
# COPY . /usr/src/app
# RUN chown -R deploy:deploy /usr/src/app
# RUN chmod -R 755 /usr/src/app
# USER deploy
ENV LOCAL_USERNAME deploy
WORKDIR /usr/src/app
