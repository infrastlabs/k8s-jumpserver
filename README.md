# k8s-jumpserver

## Modules

- jumpserver 0.3.x版Jumpserver跳板机
- jumpregister Jumpserver自注册
- alpine-ext:weak 轻量sshd (业务负载的基础镜像层)

## 快速开始

### 1.现有集群

```bash
kc apply -k https://gitee.com/infrastlabs/k8s-jumpserver//deploy
kc -n jumpregister get po -A
```

### K3S

- dcp up

```bash
export K3S_VERSION=v1.17.4-k3s1-amd64
export K3S_TOKEN=sdsdfsdfsdfsdf
docker pull rancher/k3s:${K3S_VERSION:-latest}

echo K3S_VERSION=$K3S_VERSION > .env
echo K3S_TOKEN=$K3S_TOKEN >> .env
dcp up
```

- kube-cmd

```bash
cd /opt/apps/k3s && mkdir -p .kube
cat kubeconfig.yaml > .kube/config

cd /opt/apps/k3s && docker run -it --rm -v $(pwd)/.kube:/root/.kube --network=host --entrypoint=bash registry.cn-shenzhen.aliyuncs.com/infrastlabs/kube-cmd
```

## ref

- kubernetes-auto-ingress https://github.com/hxquangnhat/kubernetes-auto-ingress
- kubetop https://github.com/siadat/kubetop

## 部署拓扑

- 全内置： jumpserver无状态
- jumpserver外置，可与物理机混合管理，可管理多个K8S集群

## 效果图

TODO

## TODO

- ~~DockerfileBuild, ref: rbac-manager~~ Done.
- ~~flags: SERVER_URL, SYNC_TIME, MATCH_LABEL, KUBECONFIG,~~ Done.
- conn err noExit
