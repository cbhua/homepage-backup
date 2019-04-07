---
layout:     post
title:      Tencent QQ Robot in Linux
subtitle:   在 Linux 上托管腾讯 QQ 机器人
date:       2019-02-16
author:     HuaChuanbo
header-img: img/post-bg-database.jpg
catalog: true
tags:
    - Linux
---
# 前言

![img](https://www.mcvuk.com/.image/t_share/MTU1NDk1MTIyMTQ5MDU4MzM5/tencent.png)

由于学校的情况，我在日常生活中比较多的使用 Tencent QQ，也加入了很多的 QQ 群，有老师建立的学术交流群，也有一群相同爱好的人组成的兴趣群。在这些群之中有些是存在机器人在群里面的，这些 QQ 机器人功能多种多样，有的可以帮助管理群，有的可以提供一些有趣的游戏或者抽卡模拟。这样的机器人可以非常好的活跃群气氛，提供一些游戏或者好玩的功能大家一起参与。于是我产生了拥有自己的 QQ 机器人的想法，并大概花了两天的时间去配置这样的机器人，并完成了本篇教程。

事实上，这篇 post 是这个 Blog 第一篇正式的**教程**，在此之前的 post 大部分都是笔记或者总结。此前我对自己能否比较清晰的撰写一篇可以让别人看得懂的教程持有怀疑态度，在经过前面几篇 post 的撰写练习之后我对自己有了一些信心，并尝试写下了这一篇 post。

![img](https://ss.csdn.net/p?https://mmbiz.qpic.cn/mmbiz_png/sG1icpcmhbiaCV9UxOLibQ5fgZhavKIcjXArPtH7Xehtk90cPoS5gslsZYHdOaUMiavT1icv78wgUK0II4UJtCtbq1w/640?wx_fmt=png)

在遇到各式各样的问题时，我们都会去搜索引擎寻找解决方案。对于遇到的问题，我们也经常碰到一些让人难以理解的回答，这些回答要么是过于简略，这样的解决方案多是由当事者事后回忆并撰写的，经常略过了不少关键细节，也有的答案本身就是错误的，这种多是回答者从其他地方参考过来，而并没有亲自去尝试带来的结果。这样的解决方案反而会给我们解决问题带来反作用。所以，在我撰写这篇教程时，尽可能的用到“提问的艺术”和“回答的艺术”，尽可能精确的去展示问题的解决方案，我也会将亲自完成这篇教程时遇到的问题记录下来，以备大家参考。

总是，善用搜索。

# 正文

## Part 1. 启用属于自己的 QQ 机器人

在最初开始了解 QQ 机器人的时候，发现有很多种类的 QQ 机器人可供选用，编写语言、平台、功能也各不相同，有的是 Github 项目，有的则是商业网站提供的。但是之后我了解到一个事实，非常多的 QQ 机器人都是基于 [Smart QQ](https://zh.wikipedia.org/wiki/Smart_QQ) 建立的，也就是不少人熟悉的 Web 版 QQ ，而 **WebQQ 该功能已于2019年1月1日停止运营**。所以此前很多的 QQ 机器人都无法使用了，在选择机器人平台的时候需要了解到位。

Smart QQ 停用对自己编写 QQ 机器人也带来了一些麻烦，本身 WebQQ 的消息传输可以直接转换为 HTML 代码过滤，来作为接收的信息。这项服务关闭之后就需要考虑其他的过滤信息的方法了。在这里我没有这么大的耐心去自己写一个机器人，也算遵守“有轮子就不自己造”的态度吧，选择了既有的机器人服务进行使用。

![kyPTC4.png](https://s2.ax1x.com/2019/02/17/kyPTC4.png)

此处推荐的是 [酷Q](https://cqp.cc/) 社区提供的 QQ 机器人，该社区提供 Air 版（Free）和 Pro 版（Charges），差别在于 Air 版无法发语音与图片，仅能以文字或者 emoji 进行交互。酷Q 社区提供了比较丰富的 应用/App，都是由用户提供，比较好的是该论坛下载是免费的（下载文件消耗 2CP，评论一次获得 2CP，等价于可以任意下载）。

由于是稳定的 QQ 机器人，酷Q 的使用非常简单，自带有教程插件，运行之后会非常细致的教你使用酷Q。但是，**如果你使用的 QQ 号是新号，强烈建议不要启用该教程，有极高的概率被冻结账号**。原因在于教程中该账号会高频率发送信息，新账号容易被判定为广告而被冻结。

在论坛寻找下载并调试一些自己感兴趣的功能插件之后，我们就可以准备将机器人托管到云服务器上了。



## Part 2. 启用云服务器

**如果你已经有自己的云服务器并已经调试好，这一部分可以跳过。**

---

准备工作：

- 了解基础的 Linux 语句

---

**部署服务器**

服务器商家有很多种，可以按照自己的喜欢选择。这里我是用的是 [**阿里云轻量级应用服务器**](https://www.aliyun.com/product/swas?spm=5176.8499797.selected.11.563d1a3f6CUrq1)，学生云翼计划年费 ￥100 多一些。入门级的服务器托管酷Q也几乎不占用服务器的内存与 CPU，云服务器可以做很多其他事情的，比如托管自己的网站，做云计算等等（如果你的服务器是境外的，当然要用来搭梯子）。当然 ECS 也是可以的，不过云服务器比较的简单。当然如果愿意折腾和更自由一些，ECS 是很好的选择。

操作系统可以自由选择，完成本教程都是大同小异，这里选用的是 CentOS。也便于未来其他方面的使用。

**连接服务器**

部署完初始化之后就可以用 SHH 连接了，方法可以参考 [Putty 配置说明](https://help.aliyun.com/document_detail/59083.html?spm=5176.10173289.107.1.2be62e77NNKrRh#windows)。

- **注意**：阿里云有三种方式进行远程连接：1. 浏览器直接连接；2. 客户端密匙连接；3. 客户端账号密码连接；

  在生成密匙后再使用账号密码登陆时会出现 `Disconnected:No supported authentication methods available` 问题，解决方案参考 [解决方案](https://help.aliyun.com/knowledge_detail/41489.html)。



## Part 3. 部署酷Q至云服务器

---

系统：CentOS 7.4

SSH App：MobaXterm

环境：Docker cotainer

下述 Linux 操作：用户 - root；主机名 - kurakun；

---

**Step 1. 配置 Docker**

安装 Docker：

`[root@kurakun ~]# sudo yum install docker`

安装完成之后启动 Docker：

`[root@kurakun ~]# sudo systemctl start docker`

查看 Docker 运行情况：

`[root@kurakun ~]# docker info`

---

 **Step 2. 配置 CoolQ (酷Q) 镜像**

下载 CoolQ 镜像（coolq.io）：

`[root@kurakun ~]# sudo docker pull coolq/wine-coolq`

查看镜像情况：

`[root@kurakun ~]# sudo docker images`

创建一个用以存放数据的 coolq-data 文件夹，创建的路径可以任意选择，这里为最顶层目录：

`[root@kurakun ~]# sudo mkdir /coolq-data`

运行 CoolQ 容器，这是最关键的一步，请仔细按照下述参数说明进行操作：

```
[root@kurakun ~]# docker run --restart=always --name wine-coolq -d \
-p 8080:9000 \
-v /coolq-data:/home/user/coolq \
-e VNC_PASSWD=12345678 \
-e COOLQ_ACCOUNT=1000000000 \
coolq/wine-coolq
```

参数说明 (其余部分均不需要修改)：

```
8080 - 远程监听端口,此端口需要云服务器防火墙通过,请参考你选择的服务商提供的信息
/coolq-data - 刚才创建的存放数据的文件夹路径
12345678 - 过一会需要登陆一个东西,这里是你要设置的登陆密码(不超8位)
1000000000 - 用以登陆酷Q的QQ号
```

- **注意**：远程监听端口设置的合适与否关系着后面能否连接酷Q，请务必选择防火墙开放的端口。以阿里云为例，选择 `概览 -> 服务器安全设置 -> 防火墙` 其中 HTTP 这一行的端口范围就是服务器开放的端口，这样上述操作中就用 `-p 80:9000` 即可。

---

**Step 3. 连接 CoolQ 并调整**

使用浏览器打开 `http://0.0.0.0:8080` ，其中 0.0.0.0 是你主机的公网 IP，8080 是你刚才设置的端口。如果前面一切顺利，你会打开一个 noVNC 的界面：

![kyPI5F.png](https://s2.ax1x.com/2019/02/17/kyPI5F.png)

连接需要输入上述 `VNC_PASSWD` 设置的密码，之后酷Q就会自动启动，正常登陆之后就完成了酷Q的连接。

- **注意**：在这里登陆酷Q需要QQ号已经开启设备锁，请用手机登陆一次QQ，在设置中将设备锁打开

之后对酷Q的调整就与 Windows 上一样了，文件就在之前所创建的 `/coolq-data` 里面，将你所需要的插件上传上去之后就可以在 VNC 上面如 Windows 一般进行调整。

新版本的 wine-coolq 容器自带重启功能：被关闭之后 10 秒之后自动重启，以支持长期后台运行。

- **注意**：目前 VNC 存在比较严重的问题：中文输入乱码，目前没有找到比较成熟的解决方案，可以考虑在windows 本地将 ini 设置文件配置好，再上传上去。

至此，酷Q配置完毕。



## Part 4. 后续调整

参考 [Docker 从入门到实践](https://legacy.gitbook.com/book/yeasy/docker_practice/details) 控制容器运行与停止：

`[root@kurakun ~]# docker start coolq`

`[root@kurakun ~]# docker stop coolq`

当然，比较好的选择就是在酷Q中安装一个机器人控制插件，这样就可以比较方便的启用和关闭机器人，并且监控机器人状态。

稳定性方面，依服务器的带宽而定，反应偶有延迟，其中的一些需要联网的功能偶尔会宕机，整体上影响不大。

**2019.3.25 Update** - 经过一段时间的测试，酷Q的回复延迟越来越长，最后稳定在 20s 左右，具体原因是系统问题、主机问题还是网络问题还在分析。另一个遇到的问题就是酷Q更新之后是需要重新登陆的，在远程的情况下需要定期连接，是比较麻烦的，而酷Q也不提供停止更新或者静默更新，目前还没有比较好的解决方法。



# 结尾

希望 Robot 可以给大家的群带来诸多的欢乐。

END.