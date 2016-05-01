ansible-playbook -i etc/ansible/hosts cluster.yml --check --limit common[0] $@
