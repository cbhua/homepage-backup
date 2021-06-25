---
title: "Minecraft 联机服务器终极教程"
date: 2021-02-16T00:00:00+09:00
hidden: false
draft: false
tags: ["教程文档"]
summary: "这里是关于如何在 Ubuntu 系统上创建一个长期运行的 Minecraft 服务器的终极教程，该服务器可以自由添加 Mods，或者使用论坛上面的整合包。网络上相关的教程较为零散，各种问题也很多，在这里我准备以我写教程的最高标准来完成这样一个搭建服务器的终极教程，展现我认为理想的教程形态应该是什么样的。"
author: "Chuanbo"
count: "3633 Words"
---

# 教程简介

Minecraft 服务器可以长期运行于一个计算设备，允许大家远程简介进行联机。

这篇教程包含：

- 在 Ubuntu 环境下搭建 Minecraft 服务器的流程，包括：原版联机服务器、基于 Forge 的联机服务器、基于论坛整合包的联机服务器。

这篇教程不包括：

- 服务器环境配置；
- Linux 知识教学；
- 游戏或者 Mods 版本选择。

# 创建原版联机服务器

原版联机服务器即不添加任何 Mods 的联机服务器。

## Step 1. 准备官方 Minecraft Server 镜像

我要做什么：把用于服务器的游戏的本体文件准备好。

我要怎么做：在 [Sakura's Mirror 镜像站](https://mirror.zerodream.net)的 [Minecraft_Server 子类](https://mirror.zerodream.net/#Minecraft_Server)下面下载对应版本的官方的 Minecraft Server 镜像。

我要做成什么样：下载了一个名为 `minecraft_server.1.12.2.jar` 的文件，版本号取决于你准备用哪个版本。

## Step 2. 运行服务器

我要做什么：顺利让服务器运行起来，让朋友可以连进去。

我要怎么做：

1. 创建一个文件夹用于存放服务器的所有文件，如 `~/Games/Minecraft/`，将刚才下载好的文件放到该文件夹下
2. 运行刚才下载好的 `minecraft_server.1.12.2.jar` 文件：`java -jar minecraft_server.1.12.2.jar`
3. 此时必然会提示 `eula=false` 因而无法启动，输入 `stop` 退出之后，修改当前目录下文件 `eula.txt` 里面的 `eula=false` 为 `eula=true`
4. 重新运行 `minecraft_server.1.12.2.jar` ：`java -jar minecraft_server.1.12.2.jar`

我要做成什么样子：顺利完成之后可以看到服务器已经运行了，有提示 `Done`

我可能遇到什么问题：

1. 没有 Java，请在 Google 上搜索你准备使用的 Minecraft 版本需要什么版本的 Java 并进行安装
2. 防火墙，Minecraft 默认会用 `25565` 端口进行连接，所以需要关闭相应端口的防火墙

## Step 3. 连接服务器

我要做什么：用本地客户端游戏连进去刚才创建好的服务器。

我要怎么做：

1. 下载和服务器版本相同的 Minecraft 客户端
2. 启动 Minecraft，在多人游戏中输入服务器 IP:Port 进行连接，如 `192.168.0.1:25565`

我要做成什么样子：如果不出意外，现在已经可以进到游戏中了

我可能遇到什么问题：

1. 网络连接问题，该问题没有通用解决方案
2. 盗版玩家被服务器拒绝，该问题请参考 Step 4

## Step 4. 调整服务器

我要做什么：针对一些需求，调整服务器。

我要怎么做：

1. 如果想让盗版的朋友也连进来，就修改服务器文件夹 `server.properties` 文件中的 `online-mode` 为 `false`
2. 如果想限定服务器内存，就在启动服务器的时候添加 `-Xms` 和 `-Xmx` 参数，如 `java -Xms12G -Xmx32G -jar minecraft_server.1.12.2.jar`

我要做成什么样子：

1. 朋友可以使用盗版游戏联入世界
2. 服务器顺利运行

# 创建自定义 Mods 服务器

在原版的基础上我们想要添加一些 Mods 在里面，提高游戏体验。

## Step 1. 准备官方 Minecraft Server 镜像

我要做什么：把用于服务器的游戏本体准备好。

我要怎么做：在 [Sakura's Mirror 镜像站](https://mirror.zerodream.net)的 [Minecraft_Server 子类](https://mirror.zerodream.net/#Minecraft_Server)下面下载对应版本的官方的 Minecraft Server 镜像。

我要做成什么样：下载了一个名为 `minecraft_server.1.12.2.jar` 的文件，版本号取决于准备用哪个版本。

## Step 2. 准备对应版本 Forge 框架

我要做什么：下载对应游戏版本的 Forge 框架。

我要怎么做：打开 [Forge 框架官网](https://files.minecraftforge.net/maven/net/minecraftforge/forge/)，左侧选择**游戏版本**，右侧点击 Show all Versions 选择 **Forge 版本**，点击下载所需要的版本的 Forge 框架文件。

我要注意什么：

1. 版本，同一个游戏版本下有很多 Forge 版本，选择版本时：游戏版本必须和服务器上运行的 Minecraft 游戏版本完全匹配，Forge 版本可以自由选择但是不同版本会影响 Mods 的兼容性，可以先确定 Forge 版本再挑选 Mods，也可以选定 Mods 之后再挑一个最稳定的 Forge 版本
2. Forge 文件类型，我们在官网可以看到 Forge 有多种，`Installer` 可以给 Widows 装也可以给 Linux 装，`Universal` 是直接给 Linux 用的，其他类型不用管，推荐用 `Installer`

我要做成什么样：下载了一个名为类似 `forge-1.12.2-14.23.5.2838-installer.jar` 的文件

## Step 3. 安装 Forge 和 Minecraft

我要做什么：把 Minecraft 装好，并且加上 Forge 框架

我要怎么做：

1. 创建一个文件夹用于存放服务器的所有文件，如 `~/Games/Minecraft/`，将刚才下载好的 Minecraft Server 文件和 Forge 文件都放到该文件夹下

2. 运行 Forge Installer：`java -jar forge-1.12.2-14.23.5.2838-installer.jar --InstallServer`

我要做成什么样：顺利运行之后，文件目录中会多出很多文件，主要是会出现一个名为类似 `forge-1.12.2-14.23.5.2838-universal.jar` 的文件

## Step 4. 运行无 Mods Minecraft

我要做什么：顺利让服务器运行起来，让朋友可以连进去。

我要怎么做：

1. 运行刚才产生的 `forge-1.12.2-14.23.5.2838-universal.jar` 文件：`java -jar forge-1.12.2-14.23.5.2838-universal.jar`
2. 此时必然会提示 `eula=false` 因而无法启动，所以修改文件 `eula.txt` 里面的 `eula=false` 为 `eula=true`
3. 重新运行 `forge-1.12.2-14.23.5.2838-universal.jar` ：`java -jar forge-1.12.2-14.23.5.2838-universal.jar`

我要做成什么样子：顺利完成之后可以看到服务器已经运行了，有提示 `Done`，并且当前文件目录出现了一些新文件，如 `mods` `world` 文件夹

我可能遇到什么问题：

1. 防火墙，Minecraft 默认会用 `25565` 端口进行连接，所以需要关闭相应端口的防火墙

## Step 5. 添加 Mods

我要做什么：给服务器运行的世界添加一些 Mods。

我要怎么做：将想要添加的 Mods 直接放在 `mods` 文件夹中，重新运行服务器即可，如果其中包含有关世界生成的 Mods，需要将 `world` 文件夹删掉再重新运行服务器

我要注意什么：Mods 版本必须完全支持当前游戏版本和 Forge 版本

我要做成什么样：服务器顺利重新运行

我可能遇到什么问题：Mods 版本不支持，请更换支持当前游戏版本和 Forge 版本的 Mods

## Step 6. 连接服务器

我要做什么：连接到服务器

我要怎么做：

1. 下载 Minecraft 启动器，有多种第三方启动器供选择
2. 安装 Forge，大部分启动器都会提供一键安装
3. 添加 Mods，进入本地 `.minecraft` 文件夹的 `mods` 文件夹，将服务器上面的 Mods 原封不动地复制过来
4. 重新启动游戏并连接，在多人游戏中输入服务器 IP:Port 进行连接，如 `192.168.0.1:25565`

我要注意什么：

1. 本地的游戏版本和 Forge 版本需要和服务器的完全一致
2. Mods 一定要从服务器原封不动复制过来，或者在上一步原封不动的从本地复制过去，保证一模一样

我要做成什么样子：如果不出意外，现在已经可以进到游戏中了，并且 Mods 运行正常

我可能遇到什么问题：

1. 网络连接问题，该问题没有通用解决方案
2. 盗版玩家被服务器拒绝，该问题请参考服务器调整部分
3. Mods 版本问题，确保本地的 Mods 是原封不动从服务器上复制过来的，如果还出问题，那么应该是本地或者服务器有一方其中的一些 Mods 有 Bug 没有运行，查看 Log 一个一个排除

## Step 7. 调整服务器

我要做什么：针对一些需求，调整服务器。

我要怎么做：

1. 如果想让盗版的朋友也连进来，就修改 [`server.properties`](http://server.properties)文件中的 `online-mode` 变为 `false`
2. 如果想限定服务器内存，就在启动服务器的时候添加 `-Xms` 和 `-Xmx` 参数，如 `java -Xms12G -Xmx32G -jar minecraft_server.1.12.2.jar`

我要做成什么样子：

1. 朋友可以使用盗版游戏联入世界
2. 服务器顺利运行

# 基于 Mods 整合包创建服务器

以 RLCraft 为例子。

## Step 1. 准备官方 Minecraft Server 镜像

我要做什么：把游戏的本体准备好。

我要怎么做：在 [Sakura's Mirror 镜像站](https://mirror.zerodream.net)的 [Minecraft_Server 子类](https://mirror.zerodream.net/#Minecraft_Server)下面下载对应版本的官方的 Minecraft Server 镜像。

我要做成什么样：下载了一个名为 `minecraft_server.1.12.2.jar` 的文件，版本号取决于整合包用哪个版本。

## Step 2. 准备对应版本 Forge 框架

我要做什么：下载对应游戏版本的 Forge 框架。

我要怎么做：打开 [Forge 框架官网](https://files.minecraftforge.net/maven/net/minecraftforge/forge/)，左侧选择**游戏版本**，右侧点击 Show all Versions 选择 **Forge 版本**，点击下载所需要的版本的 Forge 框架文件。

我要注意什么：

1. 版本，同一个游戏版本下有很多 Forge 版本，选择版本时：游戏版本必须和服务器上运行的 Minecraft 游戏版本完全匹配，Forge 版本可以自由选择但是不同版本会影响 Mods 的兼容性，可以先确定 Forge 版本再挑选 Mods，也可以选定 Mods 之后再挑一个最稳定的 Forge 版本
2. Forge 文件类型，我们在官网可以看到 Forge 有多种，`Installer` 可以给 Widows 装也可以给 Linux 装，`Universal` 是直接给 Linux 用的，其他类型不用管，推荐用 `Installer`

我要做成什么样：下载了一个名为类似 `forge-1.12.2-14.23.5.2838-installer.jar` 的文件

## Step 3. 安装 Forge 和 Minecraft

我要做什么：把 Minecraft 装好，并且加上 Forge 框架

我要怎么做：

1. 创建一个文件夹用于存放服务器的所有文件，如 `~/Games/Minecraft/`，将刚才下载好的 Minecraft Server 文件和 Forge 文件都放到该文件夹下

2. 运行 Forge Installer：`java -jar forge-1.12.2-14.23.5.2838-installer.jar --InstallServer`

我要做成什么样：顺利运行之后，文件目录中会多出很多文件，主要是会出现一个名为类似 `forge-1.12.2-14.23.5.2838-universal.jar` 的文件

## Step 4. 下载整合服务器文件

我要做什么：下载相应的服务器整合文件

我要怎么做：进入相应整合包的网站，下载相应的服务器文件整合包，以 RLCraft 为例，进入[官网](https://www.curseforge.com/minecraft/modpacks/rlcraft/files)，下载 `RLCraft Server Pack 1.12.2.zip`

我要做成什么样：下载了一个服务器的整合文件

## Step 5. 安装整合包

我要做什么：安装刚才下载好的服务器整合包

我要怎么做：直接解压覆盖到刚才运行 Forge 的文件夹即可

## Step 4. 运行服务器

我要做什么：顺利让服务器运行起来，让朋友可以连进去。

我要怎么做：

1. 运行 `forge-1.12.2-14.23.5.2838-universal.jar` 文件：`java -jar forge-1.12.2-14.23.5.2838-universal.jar`
2. 此时必然会提示 `eula=false` 因而无法启动，所以修改文件 `eula.txt` 里面的 `eula=false` 为 `eula=true`
3. 重新运行 `forge-1.12.2-14.23.5.2838-universal.jar` ：`java -jar forge-1.12.2-14.23.5.2838-universal.jar`

我要做成什么样子：顺利完成之后可以看到服务器已经运行了

我可能遇到什么问题：

1. 防火墙，Minecraft 默认会用 `25565` 端口进行连接，所以需要关闭相应端口的防火墙
2. 整合包的各种玄学问题：因为整合包一般很复杂，我们很难一个一个排除问题，这种情况下实在无法解决就只能更换整合包文件了

## Step 5. 连接服务器

我要做什么：连接到服务器

我要怎么做：

1. 下载整合包的客户端版本，解压并运行游戏
2. 连接服务器，在多人游戏中输入服务器 IP:Port 进行连接，如 `192.168.0.1:25565`

我要注意什么：

1. 客户端的整合包版本必须和服务器版本匹配，具体匹配方法请参考整合包论坛介绍

我要做成什么样子：如果不出意外，现在已经可以进到游戏中了，并且 Mods 运行正常

我可能遇到什么问题：

1. 网络连接问题，该问题没有通用解决方案
2. 盗版玩家被服务器拒绝，该问题请参考服务器调整部分

## Step 6. 调整服务器

我要做什么：针对一些需求，调整服务器。

我要怎么做：

1. 如果想让盗版的朋友也连进来，就修改 [`server.properties`](http://server.properties)文件中的 `online-mode` 变为 `false`
2. 如果想限定服务器内存，就在启动服务器的时候添加 `-Xms` 和 `-Xmx` 参数，如 `java -Xms12G -Xmx32G -jar minecraft_server.1.12.2.jar`

我要做成什么样子：

1. 朋友可以使用盗版游戏联入世界
2. 服务器顺利运行

# 其他

关于任何没有提到的问题，请在下方留言。