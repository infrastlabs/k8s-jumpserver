# sam-custom

## TODO

- ~~k3s轻环境: org版本 默认dns及初始环境镜像拉取改国内~~ Done.
- jumpserver: ~~1.初始全自动化；~~ ~~2.hostpush删增改；~~ 3.样式fix,文案；
- 
- k8s内置方案； dcp外置方案_固定ip172.26.0.100；
- ~~设计图示~~、操作手册pic
- 
- 改了image后dcp up, recreate: 重置dbSchema， noInitdata; addCron加两遍； cause err: loginErr, hostPushErr.

## route-add

```bash
route add -net 10.42.0.0/16 gw 3.4.5.3 eth0
[root@814eca8b3b78 jumpserver]# ping 10.42.1.11 
```

## infos

- 约定大于配置: alpine-ext:weak;  jumpserver:sysuser, defaultuser<jumpaddmin@web/ssh>
