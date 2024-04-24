```bash
构建镜像
docker build -t my-vnc-container .
运行容器
docker run --name=test -itd  -p 6080:6080 -p 5900:5900 -p 8088:8080 my-vnc-container

```
novnc访问地址
http://127.0.0.1:6080/vnc.html
默认密码：123456
filebrowser访问地址
http://127.0.0.1:8088
默认密码：root123456
