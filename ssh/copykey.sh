#!/bin/bash

# 不存在秘钥对就创建
if [ ! -f /root/.ssh/id_rsa ]; then
  ssh-keygen -b 2048 -t rsa -P "" -f /root/.ssh/id_rsa
  echo "id_rsa created."
else
  echo "id_rsa already exists, skip create."
fi

# 将公钥分发到各个节点
while read line; do
  echo "============================================================"
  ip=$(echo $line | awk '{print $1}')
  port=$(echo $line | awk '{print $2}')
  user=$(echo $line | awk '{print $3}')
  password=$(echo $line | awk '{print $4}')
  echo ${ip} ${port} ${user} ${password}

  expect <<EOF
  set timeout 30
  spawn ssh-copy-id -i /root/.ssh/id_rsa.pub -p ${port} ${user}@${ip}
  expect {
    "yes/no" { send "yes\n";exp_continue }
    "password" { send "${password}\n";exp_continue }
    expect eof
  }
EOF
done <hosts
