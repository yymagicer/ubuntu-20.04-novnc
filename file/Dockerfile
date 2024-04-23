FROM ubuntu:20.04
# 更换软件源为阿里云
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y curl wget

COPY filebrowser.sh filebrowser.sh

RUN bash filebrowser.sh

RUN filebrowser config init && filebrowser users add root root123456 --perm.admin=true && filebrowser config set --address 0.0.0.0 --port 8080

RUN filebrowser config set --locale zh-cn

CMD filebrowser -r / 
