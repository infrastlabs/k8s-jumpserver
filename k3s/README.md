
# K3S

## docker-compose启动

- dcp up

```bash
export K3S_TOKEN="demo-k3s-for:JumpserverTest"
export K3S_VERSION=v1.17.4-k3s1-amd64
# ns=rancher
ns=registry.cn-shenzhen.aliyuncs.com/infrastlabs
docker pull $ns/k3s:${K3S_VERSION:-latest} #pull官方image

echo K3S_VERSION=$K3S_VERSION > .env
echo K3S_TOKEN=$K3S_TOKEN >> .env
dcp up -d
#dcp up -d --scale agent=2
dcp scale agent=2
```

- kube-cmd

```bash
test -L /opt/apps/k3s && rm -f /opt/apps/k3s
ln -s $(pwd)/k3s /opt/apps/k3s 

cd /opt/apps/k3s && mkdir -p .kube
cat kubeconfig.yaml > .kube/config

cd /opt/apps/k3s && docker run -it --rm -v $(pwd)/.kube:/root/.kube --network=host --entrypoint=bash registry.cn-shenzhen.aliyuncs.com/infrastlabs/kube-cmd
```

## docker-compose.yml改动

- 改用aliyun镜像: `registry.cn-shenzhen.aliyuncs.com/infrastlabs/k3s:${K3S_VERSION:-latest}`
- volume挂载盘: 使用相对路径`./k3s-server`
- 设定k3snet网段: `3.4.5.0/24`, for jumpserver's static ip: `3.4.5.100`
- 设定NodePort端口段: `–service-node-port-range=30000-30050` #1-65535 #默认范围（30000-32767)
