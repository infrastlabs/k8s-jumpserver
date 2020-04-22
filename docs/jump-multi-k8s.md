# 外置版Jumpserver

外置版可对多类资产、多集群混合管理，可节省资源及多套跳板机管理成本，同时可配套外置mysql做存储，相比于内置sqlite性能及稳定性更佳。 最后总结：当前这套方案适合中小集群、小规模的跳板机注册与POD管理

**物理机/容器纳管**

- 物理机管理：现有支持在WEB面板人工录入物理机器
- docker-compose单机板容器管理： 正在支持中。(需要在镜像或是启动命令处做支持)
- k8s集群内pod容器管理： 全自动化，K8S容器版跳板机，POD自注册

## 快速体验（三步走）

- 1.[初始k3s轻集群](../k3s/README.md)
- 2.设定jumpregister地址`args: -jumpurl=http://3.4.5.100`, `kc apply -f ./deploy`
- 3.在一步基础上回到上一层目录，`dcp up -d`. 再访问跳板机web: 8888, ssh: 2222即可

```bash
cd /opt/k8-jump/k3s && mkdir -p .kube
set +C && cat kubeconfig.yaml > .kube/config

# 启动一个临时kubecmd控制台
img=registry.cn-shenzhen.aliyuncs.com/infrastlabs/kube-cmd
cd /opt/k8-jump/k3s && docker run -it --rm -v $(pwd):/root --network=host --entrypoint=bash $img #注意这里挂载到/root了
kc apply -f /root/deploy #进到kubecmd容器内执行
```

**简化说明**

为了简化操作jumpserver 及 k3s做了匹配关联：

- k3s的docker-compose设定网段为`3.4.5.0/24`
- jumpserver的复用k3s的网络，ip固定为`3.4.5.100`
- jumpserver与k3s的节点在同一网络，并且在`docker-compose.yml`做了路由打通到k3s中pod的网络(如您也用外置模式，同理需要手工打通路由 jumpserver才能顺利连接到pod)
