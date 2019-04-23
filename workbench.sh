#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

if [[ -f "$DIR/.config" ]]; then
	. $DIR/.config
	touch $DIR/.home/.bashrc
	echo "alias k8s='ssh root@$K8S_HOST -p $SSH_HOST'" > $DIR/.home/.bashrc
fi

if [[ -d "$DIR/.secrets" ]]; then
    echo "Adding ssh key..."
	cp $DIR/.secrets/.ssh/id_rsa $DIR/.home/.ssh/
	touch $DIR/.home/.ssh/config
	echo "ServerAliveInterval 120" > $DIR/.home/.ssh/config
fi

echo "Building workbench image. This may take a while..."
IMG=$(docker build ./.workbench \
    --quiet \
    --build-arg KUBESPRAY_VERSION="$KUBESPRAY_VERSION" \
    --build-arg KUBECTL_VERSION="$KUBECTL_VERSION" \
    --build-arg HELM_VERSION="$HELM_VERSION" \
    --network host )

mkdir -p $DIR/.home
docker run --rm \
    -u $(id -u):$(id -g) \
    -v /etc/passwd:/etc/passwd \
    -v /etc/group:/etc/group \
    -v $DIR:/work \
    -v $DIR/.home:$HOME \
    -e SECRETS_KEY="$SECRETS_KEY" \
    -w /work \
    -it $IMG $@