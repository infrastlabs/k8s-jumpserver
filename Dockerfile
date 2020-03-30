# Build the manager binary
FROM registry.cn-shenzhen.aliyuncs.com/infrastlabs/golang:1.13.9-alpine3.10 as builder
ARG dir=/go/src/devcn.fun/infrastlabs/jumpregister

# Copy in the go src
WORKDIR ${dir}
COPY . .

# use go modules
ENV GO111MODULE=on
ENV GOPROXY=https://goproxy.cn

# Build
RUN pwd && ls -h && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o jumpregister ${dir}/

# Copy data into a empty image
FROM registry.cn-shenzhen.aliyuncs.com/infrastlabs/alpine-ext
MAINTAINER sam <sldevsir@126.com>
ARG dir=/go/devcn.fun/infrastlabs/jumpregister

USER root
WORKDIR /app
COPY --from=builder ${dir}/jumpregister /app

# Configure Docker Container
# VOLUME ["/data"]
# EXPOSE 8000
ENTRYPOINT ["./jumpregister"]
