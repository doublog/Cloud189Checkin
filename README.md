# Cloud189Checkin

vps版天翼云盘每日签到+抽奖<br>
使用方法<br>
1.使用vps运行，我个人使用的CentOS 7，其他Linux系统使用方式大同小异<br>
2.测试环境为python3.9.5，如果没有安装或自带python2，建议自行安装python3<br>
3.需要将此py文件下载后，在脚本内直接填写你的账号密码<br>
4.支持微信server酱和telegram bot通知，如需使用请自行注册server酱服务或自建一个telegram bot<br>
5.支持定时运行<br>
<br>
<br>

登录看的以下项目：
> [Cloud189](https://github.com/Dawnnnnnn/Cloud189)
> [cloud189](https://github.com/Aruelius/cloud189)


# 前期工作
请下载本仓库内的 C189Checkin.py 文件进行修改<br>
需要修改的主要是你的天翼云账户密码、微信server酱的sendkey（选填），<br>
电报bot的token和user id（也是选填，不需要就直接把对应的代码用#注释掉）<br>
具体修改内容请看其后的注释<br>

# 如何使用
1.连接你的vps，确认已经安装了python后，使用pip3命令安装需要的模块：
```
pip3 install requests
pip3 install rsa
pip3 install python-telegram-bot
```
2.创建专门的文件夹Cloud189Checkin，进入文件夹中<br>
```
mkdir Cloud189Checkin
cd Cloud189Checkin
```
3.上传修改好的py文件到Cloud189Checkin文件夹中<br>
关于如何上传，我用的filezilla的sftp功能，你也可将此项目fork到你的仓库后，修改py文件内容并保持，然后运行命令：<br>
（要下载在Cloud189Checkin文件夹内）
```
wget https://github.com/你的GitHub账号名/Cloud189Checkin/blob/master/C189Checkin.py
```
4.尝试运行脚本<br>
```
cd /root/Cloud189Checkin/ && /usr/local/bin/python3 /root/Cloud189Checkin/C189Checkin.py
```
如果运行成功，就可设置定时任务<br>
<br>
5.定时任务<br>
在设置定时任务之前先确认你的vps的时区和系统时间：<br>
```
date
```
如何不是东八区时间，建议修改<br>
```
timedatectl set-timezone Asia/Shanghai
```
这样方便我们设置定时运行的时间（我之前没注意这点vps一直是美国东海岸时区，所有设定的运行时间都和实际时间差了12小时……）<br>
5.1 安装并启动crondtab<br>
首先要安装crontab，已安装的朋友可跳过<br>
```
yum -y install cronie crontabs
```
验证crond是否安装及启动<br>
```
yum list cronie && systemctl status crond
```
验证crontab是否安装<br>
```
yum list crontabs $$ which crontab && crontab -l
```
5.2 设置定时运行<br>
打开任务表单，并编辑：<br>
```
crontab -e
```
按i进入输入模式，输入如下内容后，按住esc键，输入:wq保持并退出编辑模式<br>
```
00 09 * * * cd /root/Cloud189Checkin/ && /usr/local/bin/python3 /root/Cloud189Checkin/C189Checkin.py
```
此任务的含义是在每天早上9点执行签到任务<br>

重启crond守护进程（每次编辑定时任务后都需此步，以使任务生效，或者简单粗暴直接reboot）<br>
```
systemctl restart crond
```


<br>
<br>


# 使用Server酱的推送服务

使用`-e SCKEY="你的KEY"`即可，关于Server酱详见其[官网](https://sc.ftqq.com/3.version)

