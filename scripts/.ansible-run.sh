#! /bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook \
            -u root \
            --private-key=/work/.secrets/.ssh/id_rsa \
            -i /work/target/kubespray/inventory/netcup/hosts.ini \
            --become \
            $@
