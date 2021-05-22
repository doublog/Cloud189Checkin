# Cloud189Checkin

天翼云盘每日签到一次，抽奖2次<br>
使用方法<br>
1.测试环境为python3.7.6,自行安装python3<br>
2.requirements.txt 是所需第三方模块，执行 `pip install -r requirements.txt` 安装模块<br>
3.可在脚本内直接填写账号密码<br>
4.Python 和需要模块都装好了直接在目录 cmd 运行所要运行的脚本。
*****
5.新增telegram bot通知（无法提示签到成功与否）
6.新增docker定时运行<br>
<br>
<br>

登录看的以下项目：
> [Cloud189](https://github.com/Dawnnnnnn/Cloud189)
> [cloud189](https://github.com/Aruelius/cloud189)


# 前期工作
首先把我的这个项目fork到你自己的仓库中，然后点进 C189Checkin.py 文件进行修改
需要修改的主要是你的天翼云账户密码、微信server酱的sendkey（选填），电报bot的token和user id（也是选填，不需要就直接留空）
具体修改内容请看其后的注释
由于我太菜，电报通知没法显示签到成功没有，只能告诉你签到运行了一次……

# 在Docker中使用

1.获取文件到本地
----

```zsh
git clone https://github.com/ChellyL/Cloud189Checkin.git
cd Cloud189Checkin
```

2.构造镜像
-----

```zsh
docker build -t yourname/cloud189checkin .
```

最后有一个点别忘了

3.运行容器
-----

```zsh
docker run -it yourname/cloud189checkin
```

4.定时任务（可选）
-----
在设置定时任务之前先确认你的vps的时区和系统时间：
```
date
```
如何不是东八区时间，建议修改
```
timedatectl set-timezone Asia/Shanghai
```
这样方便我们设置定时运行的时间（我之前没注意这点vps一直是美国东海岸时区，所有设定的运行时间都和实际时间差了12小时……）
## 4.1 安装并启动crondtab
首先要安装crontab，已安装的朋友可跳过
```
yum -y install cronie crontabs
```
验证crond是否安装及启动
```
yum list cronie && systemctl status crond
```
验证crontab是否安装
```
yum list crontabs $$ which crontab && crontab -l
```
## 查找dockers的container id
输入以下指令：
```
docker image ls
```
找到yourname/cloud189checkin对应的 image ID
接着尝试删除它：
```
docker rmi image ID
```
此时系统会提示你
>Error response from daemon: conflict: unable to delete 一串image ID (must be forced) - image is being used by stopped container 一串container ID
复制下最后的container ID

## 4.2 设置定时任务
打开任务表单，并编辑：
```
crontab -e
```
按i进入输入模式，输入如下内容后，按住esc键，输入:wq保持并退出编辑模式
```
00 09 * * * docker start 你的containerID
```
此任务的含义是在每天早上9点执行签到任务

重启crond守护进程（每次编辑定时任务后都需此步，以使任务生效，或者简单除暴直接reboot）
```
systemctl restart crond
```

知道了container ID 后也可以直接使用
```
docker start 你的containerID
```
来运行该签到




使用群晖任务计划实现定时每日定时签到
-----

首先使用ssh连接到群晖，键入`sudo su`并输入密码获取root权限，随后***找一个合适的目录***执行步骤1、2、3，**例**：

```zsh
sudo su
mkdir /volume2/myfiles/docker && cd /volume2/myfiles/docker
git clone https://github.com/L-Trump/Cloud189Checkin.git
cd Cloud189Checkin
docker build -t yourname/cloud189checkin .
docker run -e USERNAME="你的账号" -e PASSWORD="你的密码" -e SCKEY="你的Server酱KEY" -it yourname/cloud189checkin
```

使用`docker ps -a`查找刚刚运行的docker的id，结果如图

![Snipaste_2020-07-16_09-22-46.png](https://xqhma.oss-cn-hangzhou.aliyuncs.com/image/Snipaste_2020-07-16_09-22-46.png)

在这里id为eea2738600f9，记录下后进入群晖的管理页面-控制面板-任务计划-新增-用户定义的脚本

随后在任务设置的运行命令中填入`docker start 你的Dockerid -i`即可：

![Snipaste_2020-07-16_09-27-35.png](https://xqhma.oss-cn-hangzhou.aliyuncs.com/image/Snipaste_2020-07-16_09-27-35.png)

**注：由于该docker在签到完后就会停止运行，群晖在消息里提示意外停止，忽略就好，如果有知道怎么解决的大神欢迎联系我**

# 使用Server酱的推送服务

使用`-e SCKEY="你的KEY"`即可，关于Server酱详见其[官网](https://sc.ftqq.com/3.version)

