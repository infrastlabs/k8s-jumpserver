
# 快速初始K3S轻集群

## docker-compose快速启动

- dcp up

(注1: `dcp`为`docker-compose`简写: `ln -s /usr/local/bin/docker-compose dcp`)

```bash
# 克隆仓库
# repo=https://github.com/infrastlabs/k8s-jumpserver
repo=https://gitee.com/infrastlabs/k8s-jumpserver
cd /opt && git clone $repo k8-jump
cd /opt/k8-jump/k3s

# 先手工拉取镜像
export K3S_TOKEN="demo-k3s-for:JumpserverTest"
export K3S_VERSION=v1.20.0-k3s2-amd64 #v1.19.5-k3s2-amd64 #v1.17.4-k3s1-amd64
# ns=rancher
ns=registry.cn-shenzhen.aliyuncs.com/infrastlabs
docker pull $ns/k3s:${K3S_VERSION:-latest} #pull官方image

# 初始docker-compose参数
echo K3S_VERSION=$K3S_VERSION > .env
echo K3S_TOKEN=$K3S_TOKEN >> .env
dcp up -d #拉起k3s集群：一Master, 一agent
dcp scale agent=2 #形成两个agent+ 1Master的三节点集群
```

- kube-cmd

(注2: kubecmd内 `kc` 为 `kubectl`的简写: `ln -s /usr/local/bin/kubectl kc`）

```bash
cd /opt/k8-jump/k3s && mkdir -p .kube
set +C && cat .kube/kubeconfig.yaml > .kube/config
# 启动一个临时kubecmd控制台
img=registry.cn-shenzhen.aliyuncs.com/infrastlabs/kube-cmd
cd /opt/k8-jump/k3s && docker run -it --rm -v $(pwd)/.kube:/root/.kube --network=host --entrypoint=bash $img
```

- 通用集群插件: TODO

## `docker-compose.yml` 改动说明

- 改用aliyun镜像: `registry.cn-shenzhen.aliyuncs.com/infrastlabs/k3s:${K3S_VERSION:-latest}`
- volume挂载盘: 使用相对路径`./k3s-server` 
- ~~设定Master节点主机名: `hostname: k3-server`~~ (如设置固定名`dcp down/up`重建时`/var/lib/rancher/k3s/server/cred/node-passwd`导致master节点无法注册 )
- 设定k3snet网段: `3.4.5.0/24`, for jumpserver's static ip: `3.4.5.100`
- 设定NodePort端口段: `–service-node-port-range=30000-30050` #1-65535 #默认范围（30000-32767)
- docker.sock透传: `/var/run/docker.sock`
