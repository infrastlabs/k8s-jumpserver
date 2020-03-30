# k8s-jumpserver

## Modules

- jumpserver 0.3.x版Jumpserver跳板机
- jumpregister Jumpserver自注册
- alpine-ext:weak 轻量sshd (业务负载的基础镜像层)

## ref

- kubernetes-auto-ingress https://github.com/hxquangnhat/kubernetes-auto-ingress
- kubetop https://github.com/siadat/kubetop

## 部署拓扑

- 全内置： jumpserver无状态
- jumpserver外置，可与物理机混合管理，可管理多个K8S集群

## 效果图

TODO

## TODO

- DockerfileBuild, ref: rbac-manager
- flags: SYNC_TIME, MATCH_LABEL, KUBECONFIG,
- conn err noExit
