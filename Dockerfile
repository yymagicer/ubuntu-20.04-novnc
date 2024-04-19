FROM ubuntu:20.04

# 更换软件源为阿里云
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

# 安装必要的软件包
RUN apt-get update 

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y ubuntu-desktop gnome

RUN apt-get install -y tigervnc-standalone-server \
        tigervnc-xorg-extension \
        novnc \
        supervisor \
        xterm \
        fluxbox \
        wget \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y tigervnc-common  xvfb gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal expect vim

RUN apt-get install -y  language-pack-zh-hans language-pack-gnome-zh-hans language-pack-zh-hans-base language-pack-gnome-zh-hans-base 
# 设置 supervisord
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir -p /usr/share/novnc

ADD  novnc-1.4.0.tar.gz /usr/share/novnc/

RUN chmod +x /usr/share/novnc/utils/*.sh


USER root
ENV LANG=C.UTF-8
ENV LANG=zh_CN.UTF-8
ENV LANGUAGE=zh_CN:zh
ENV LC_ALL=zh_CN.UTF-8

# 设置系统的默认语言为中文
RUN update-locale LANG=zh_CN.UTF-8 LANGUAGE=zh_CN:zh LC_ALL=zh_CN.UTF-8

# 设置密码
RUN mkdir -p /root/.vnc 

#RUN echo "123456" | iconv -t utf8 | x11vnc -storepasswd - /root/.vnc/passwd

RUN echo "123456" | vncpasswd -f > /root/.vnc/passwd && chmod 600 /root/.vnc/passwd

#RUN echo "123456" > /root/.vnc/passwd

COPY xstartup  /root/.vnc/xstartup

RUN chmod 777  /root/.vnc/xstartup

RUN rm -rf /var/lib/apt/lists/*
# 设置启动命令
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

