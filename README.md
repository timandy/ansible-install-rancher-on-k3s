# 在线安装 k3s 高可用集群并在 k3s 集群内安装高可用的 rancher
### 1、下载所需文件

下载Ansible部署文件：

```
git clone https://github.com/timandy/ansible-install-rancher-on-k3s.git
cd ansible-install-rancher-on-k3s
```

### 2、修改Ansible文件

修改hosts文件，根据规划修改对应IP和名称。

修改group_vars/all.yml文件，修改配置。

### 3、生成免密登录秘钥并分发

```
cd ssh
```
在管理机器上执行 install.sh 安装分发公钥所需要的软件。

修改 ssh 目录下的 hosts。

执行 copykey.sh 生成并分发秘钥。

## 4、一键部署

### 安装 docker
```
ansible-playbook -i hosts docker.yml
```

### 部署命令
```
ansible-playbook -i hosts install.yml
```

## 卸载命令
```
ansible-playbook -i hosts uninstall.yml
```

注意: 卸载的时候会删除所有包含 `k8s` 容器并清理镜像. 参见 [./roles/uninstall/tasks/main.yml](roles/uninstall/tasks/main.yml)

## 问题
 ```
Using a SSH password instead of a key is not possible because Host Key checking is enabled and sshpass does not support this.  Please add this host's fingerprint to your known_hosts file to manage this host.

vi /etc/ansible/ansible.cfg

#host_key_checking = False
修改为
host_key_checking = False

```
