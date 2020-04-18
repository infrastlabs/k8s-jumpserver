
# K3S

- dcp up

```bash
export K3S_VERSION=v1.17.4-k3s1-amd64
export K3S_TOKEN=sdsdfsdfsdfsdf
docker pull rancher/k3s:${K3S_VERSION:-latest}

echo K3S_VERSION=$K3S_VERSION > .env
echo K3S_TOKEN=$K3S_TOKEN >> .env
dcp up -d
#dcp up -d --scale agent=2
```

- kube-cmd

```bash
test -L /opt/apps/k3s && rm -f /opt/apps/k3s
ln -s $(pwd)/k3s /opt/apps/k3s 

cd /opt/apps/k3s && mkdir -p .kube
cat kubeconfig.yaml > .kube/config

cd /opt/apps/k3s && docker run -it --rm -v $(pwd)/.kube:/root/.kube --network=host --entrypoint=bash registry.cn-shenzhen.aliyuncs.com/infrastlabs/kube-cmd
```
