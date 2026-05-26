#!/bin/bash
set -e

apt-get update
apt-get install -y \
ansible \
sshpass \
git \
curl \
vim

echo "Control-node configurado!"


# #/bin/sh
# sudo yum -y install epel-release
# echo "inicio da instalacao do ansible"
# sudo yum -y install ansible
# cat <<EOT >> /etc/hosts
# 192.168.1.2 control-node
# 192.168.1.3 app01
# 192.168.1.4 db01
# EOT
