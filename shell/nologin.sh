#!/usr/bin/env bash
# 免登录配置
# 1.在跳板机上执行
ssh-copy-id -i .ssh/id_rsa.pub user@targethost

# 2.在源机器上执行
mkdir .ssh
chmod 700 .ssh
scp user@targethost:~/.ssh/id_rsa.pub .ssh/authorized_keys
chmod 600 .ssh/authorized_keys
