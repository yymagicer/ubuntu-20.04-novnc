```bash
构建镜像
docker build -t my-vnc-container .
运行容器
docker run --name=test -itd  -p 6080:6080 -p 5900:5900 my-vnc-container

```
访问地址
http://127.0.0.1:6080/vnc.html
默认密码：123456
