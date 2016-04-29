#!/usr/bin/env bash
ansible -i ./etc/ansible/hosts all -m setup --tree /tmp/facts $@
