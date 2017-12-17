#!/bin/bash

usage() {
    echo "Usage ./arm-binaries options"
    echo "Options availale:"
    echo "    -f | --flanel: build flannel binary"
    echo "    -k | --kubernetes: build/fetch kubernetes binaries"
    echo "    -e | --etcd: build etcd binaries"
    echo "    -a | --all: build/fetch all binaries"
    echo "    -h | --help: display this message"
}


OPTS=`getopt -ofekah --long flannel,etcd,kubernetes,all,help -n 'parse-options' -- "$@"`
eval set -- "$OPTS"

ANSIBLE_DIR=$(pwd)
FLANNEL=false
ETCD=false
KUBERNETES=false
HELP=false

while true; do
    case "$1" in
        -f | --flannel ) FLANNEL=true; shift -- ;;
        -e | --etcd ) ETCD=true; shift -- ;;
        -k | --kubernetes) KUBERNETES=true; shift -- ;;
        -a | --all) FLANNEL=true; ETCD=true; KUBERNETES=true; shift -- ;;
        -h | --help) HELP=true; shift --;;
        -- ) shift; break ;;
        *) break ;;
    esac
done

if [[ $HELP == true ]]; then
    usage
    exit
fi

if [[ $ETCD == true ]]; then
    echo "Building etcd..."
    cd ..
    if [[ -e etcd && -d etcd ]]; then
        cd etcd && git pull origin master
    else
        git clone https://github.com/coreos/etcd && cd etcd
    fi
    docker run -v $(pwd):/usr/src/app -w /usr/src/app -e GOARCH=arm -e GOPATH=/go:/usr/src/app golang ./build
    echo "Copying binaries to ${ANSIBLE_DIR}/roles/etcd/files"
    cp bin/etcd* ${ANSIBLE_DIR}/roles/etcd/files
fi

cd ${ANSIBLE_DIR}
if [[ $KUBERNETES == true ]]; then
    echo "Downloading kubernetes 1.9.0"
    wget https://dl.k8s.io/v1.9.0/kubernetes-client-linux-arm.tar.gz
    wget https://dl.k8s.io/v1.9.0/kubernetes-server-linux-arm.tar.gz
    tar -xvf kubernetes-client-linux-arm.tar.gz
    tar -xvf kubernetes-server-linux-arm.tar.gz
    echo "Copying kubernetes binaries to ${ANSIBLE_DIR}/roles/kubernetes/files"
    cp kubernetes/**/bin/* roles/kubernetes/files
fi

if [[ $FLANNEL == true ]]; then
    echo "Building flannel..... loljk"
fi
