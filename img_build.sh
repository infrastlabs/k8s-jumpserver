
#echo "export DOCKER_REGISTRY_USER_sdsir=xxx" >> /etc/profile
#echo "export DOCKER_REGISTRY_PW_sdsir=xxx" >> /etc/profile

source /etc/profile
export |grep DOCKER_REG

repo=registry.cn-shenzhen.aliyuncs.com
echo "${DOCKER_REGISTRY_PW_sdsir}" |docker login --username=${DOCKER_REGISTRY_USER_sdsir} --password-stdin $repo

ns=infrastlabs
img="jumpregister:latest"
docker build --pull -t $repo/$ns/$img .
docker push $repo/$ns/$img

