#!/usr/bin/env bash
# ���¼����
# 1.���������ִ��
ssh-copy-id -i .ssh/id_rsa.pub user@targethost

# 2.��Դ������ִ��
mkdir .ssh
chmod 700 .ssh
scp user@targethost:~/.ssh/id_rsa.pub .ssh/authorized_keys
chmod 600 .ssh/authorized_keys
