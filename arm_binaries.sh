#!/bin/bash

ANSIBLE_DIR=$(pwd)
cd ..
if [[ -e etcd && -d etcd ]]; then
    cd etcd && git pull origin master
else
    git clone https://github.com/coreos/etcd && cd etcd
fi

docker run -v $(pwd):/usr/src/app -w /usr/src/app -e GOARCH=arm -e GOPATH=/go:/usr/src/app golang ./build
cp bin/etcd* ${ANSIBLE_DIR}/roles/etcd/files
#
#wget https://dl.k8s.io/v1.9.0/kubernetes-client-linux-arm.tar.gz
##wget https://dl.k8s.io/v1.9.0/kubernetes-server-linux-arm.tar.gz
#tar -xvf kubernetes-client-linux-arm.tar.gz
#tar -xvf kubernetes-server-linux-arm.tar.gz

#cp kubernetes/**/bin/* roles/kubernetes/files
