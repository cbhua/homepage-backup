---
title:      在 Linux 平台创建 Minecraft Forge 服务器
date:       2020-02-15
author:     Chuanbo HUA
description: "在 Linux 平台上运行一个具有 Forge 框架的 Minecraft 服务器供朋友之间联机。"
tags: ["ACG", "Linux"]
categories: ["Tutorial"]
---



作为一个独立游戏爱好者，自然在平时与朋友联机过很多种游戏。由于独立游戏普遍缺少良好的官方联机渠道或者联机解决方案，搭建自己的服务器成了必修课。这些游戏包括但不限于：

- **饥荒联机版（Do not starve together）**：由于饥荒联机版那糟糕的优化，在多人联机的时候对主机具有很高的运算、网络要求；另外服务器稳定性变数较多，整体上比较影响游戏体验；我曾经写过 DST 的服务器架设教程，不过由于其实在占用资源太多，导致六人以上的服务器联机会使我那可怜的单核2G服务器崩溃，最后只好作罢；
- **火炬之光 I & II（Torch Light I & II）**：在 2020 年，火炬之光的官方服务器只能以“土豆”来形容，不过也是自然可以理解的事情，玩家已经太少，平常也只有个位数的服务器在运行；
- **泰拉瑞亚（Terraria）**：Terraria Steam 官方提供的联机解决方案实际上相当的完善，质量也比较好，但是对于一些 Mods 或许需要自己架设服务器来提供运行；

除此之外有时候为了最求更好的游戏体验而建设自己的服务器，比如百人以上大型联机、24h 运行服务器等等。

我的世界（Minecraft）官方提供**领域**供大家联机使用，但是经常有延时问题，而且自由度有限。绝大多数玩家还是选择架设自己的服务器，关于架设服务器的好处就不说了，如果你要好好读这篇文章，那么说明你有这个需求，好坏处自然了解。

**这篇文章主要介绍在 Linux 环境下架设一个基于 Sponge Server 的 Minecraft 服务器，其框架选择是 Forge，该服务器主要提供原版联机、Mod 加入、插件加入的功能。**

~~如果你并不想自己学习怎么架设，那么可以直接翻到最后，下载 1.12.2 版本的整合包直接放到服务器中运行即可。~~

文章假设：

- 阅读者已经有了可供开服的服务器，如阿里云轻量应用服务器 OR ECS，腾讯轻量应用服务器，甚至你家树莓派；
- 阅读者有很基础的 Linux 知识，能 SSH 连接，能 ftp 上传文件，能在解读下大致理解这篇文章中的 Commands；
- 阅读者对 Minecraft 有一些基础的了解，已经选择好了要做服务器的游戏版本，准备了 Mods 和一些插件；
- 阅读者有朋友一起玩 Minecraft，鸽了的话你这个服务器也就白搭（两种意思）；

那我们开始。

**2020.02.18 Update** - 在联机尝试了两天之后，发现阿里云的服务器的算力实在不足（不得不说我用阿里云搞联机一次没成过，都是卡在性能上），所以拿手里的开发笔记本来当服务器。所以说如果是和朋友联机，为了游戏体验，如果有一台多余的电脑，让它做服务器是最好了。过程上只需要在下面教程顺利完成之后在家里路由器添加一个虚拟服务器转发 25565 端口到你的开服电脑上，之后把家里的公网 IP 发个同学。

## 准备 Minecraft Server 本体

**N.B.** *步骤 2 准备 Minecraft Server 本体* 和 *步骤 3 加入 Forge 框架* 可以不在服务器中进行，可以选择在 Windows 下完成之后通过 ftp 上传。在这里**我更加推荐在 Windows 下进行这一部分**。

你可以在 [Sakura’s Mirror by Akkariin](https://mirror.zerodream.net/) 这个网站找到各种各样的 Minecraft Server 镜像源，在这里我选用官方的原版服务器：选择右上角“选择分类”、Minecraft Server、选择需要的版本进行下载。

如 1.12.2 版本的 Server 可以通过[此链接](https://mirror.zerodream.net/download/Minecraft_Server/minecraft_server.1.12.2.jar)下载。

之后**请检查你的服务器是否有满足要求版本的 Java**，只要你的 Minecraft 版本不早于 1.7.2，这里都建议你安装 Java 8。具体安装方法请参考你所使用的 Linux 发行版进行搜索。这里请不要急着运行该 Server。

## 加入 Forge 框架

你可以在 [Forge 官方网站](https://files.minecraftforge.net/maven/net/minecraftforge/forge/) 下载你需要的 Forge 框架。进入网站之后在左侧选择你的游戏版本，之后右侧会提供对应此 Minecraft 版本的 Forge 安装文件：

- **Windows Installer** 顾名思义是给 Windows 端 Minecraft 安装 Forge 用的，也就是游戏端；
- **Universal** 是给服务器端安装使用的，架设服务器需要下载这个；

需要注意的是 Forge 也会有非常多的版本，版本的选择至关服务器是否能运行：

- 如果对 Mods 有一定了解，那么肯定会知道**不同 Mods 兼容的 Forge 版本不同**，如果选择了不兼容版本的 Forge 会导致 Mods 无法加载。所以在选择 Forge 版本的时候参考你所准备添加的 Mods，确保所有 Mods 可以在你选择的 Forge 版本上顺利运行；

- 如果你打算加入 Sponge Server 这个 Mods，请在下载 Sponge Server Jar 的时候**确保其版本和 Forge 一模一样**，否则会引起不稳定甚至无法运行；

  **N.B.** 这里值得说一句的是 Sponge Server 的加载原理实际上和其他 Mods 没有太多不同，其本质可以理解为一个 Mod；

之后就可以进行 Forge 的安装了：

- 如果是在 Windows 平台，那么运行 Jar 之后选择 `Install Server`，选择放着 Minecraft Server 本体的文件夹。此处可以忽略*“There are already files at the target directory.”*的提示；

  **N.B.** 请专门为 Minecraft Server 建一个文件夹，在进行这一步前把 Minecraft Server 本体移动进去；

  **N.B.** 安装过程中或许会发生“下载失败”的 Error，这时候可以重新进行上述步骤，下载会从断点处继续进行；

- 如果是在 Linux 平台，那么方法类似：`java -jar forge-你的版本号-installer.jar` 运行 Jar 之后同样选择 `Install Server`，选择放着 Minecraft Server 本体的文件夹，注意事项同 Windows；

到此为止我们得到了一个 Forge 框架的 Minecraft Server。如果以上步骤你是在 Windows 平台进行的，那么是时候通过 ftp 上传到你的 Linux 服务器上了。直接将上述安装好 Forge 的文件夹传输即可。

## 运行服务器 & 加入 Mods

**N.B.** 以下内容均在服务器端进行。

如果上述步骤没有出现问题，那么现在服务器文件夹中应该会有 Forge 的 Universal Jar 包，其名称大致为：`forge-你的版本号-universal.jar`。

运行该 Jar 包：`java -jar forge-你的版本号-universal.jar` 以启动服务器。

第一次启动会遇到一个大致意思为 Eula 禁止的提示，这种情况只需要修改文件 `eula.txt` 中为 `Eula=True` 即可。修改之后重新运行，运行时间取决于你的服务器运算性能。

顺利运行完成之后命令行会有 `Done` 的提示，这时候说明服务器已经顺利运行了。之后用 `stop` 指令关闭服务器，我们来加入一些 Mods。

这次重新运行之后你会发现源文件夹里面出现了很多新文件，其中就有 Mods 文件夹。这时候你就可以把你所要加入的 Mods 上传到这个文件夹中。然后重新运行服务器，这次加载时间会大幅度增加，取决于你添加 Mods 的复杂程度。

如果你的 Mods 选择没有问题，那么这次服务器会正常开始运行。但是在激动的和同学连接进入之前，这里有一些设置可以改一改。

在 `server.properties` 文件中：

- `difficulty` 游戏难度：1-简单，2-普通，3-困难，也可以用 Minecraft 内建指令修改；
- `spawn-protection` 出生点保护，出生点半径内的物体无法破坏；
- `online-mod` 如果为 True，那么只有正版玩家可以连接进入，如果为 False 那么不论正版盗版玩家都可以连接进入，作为玩家群体筛选；

更改之后可以重新运行服务器。到此为止一个带 Mods 的 Minecraft Server 已经建立好了。下面来解决一些常见的连接问题：

- 别忘了在服务器的防火墙中开放 25565 端口，该端口是 Minecraft 的连接端口；
- 注意游戏端应与服务端具有相同的 Mods 和各类版本，以获得稳定的游戏体验，推荐直接把服务器上 Mods 复制到自己的游戏端下；
- 连接方式：多人游戏，直接连接，输入服务器公网 IP，连接 即可；

其实，如果你并不需要 Sponge 为你带来的插件添加功能，那么到此为止你已经可以和同学开始玩了。

## Sponge Server 和插件

如果你想体验插件带来的方便，那么就要加入 Sponge 了。加入 Sponge 的方法与其他 Mods 并无差距，你可以直接将其上传至 Mods 文件夹中并重新加载服务器。

之后就可以在 Server 中添加插件。添加插件的方法也和 Mods 一样，直接将插件的 jar 上传至 Mods 文件夹并重新加载。但是值得注意的是**插件的配置文件并不在 Mods 文件夹下**，而是在 config 文件夹下，如果有修改的需求请注意文件位置。

另一点值得注意的是**插件并不需要游戏端加载**，只需要加入服务端即可。

至此一个完整的 Sponge Server 架设完成。

## 整合包[已失效]

**N.B. 由于网盘服务器到期，这个链接失效了，我会传到其他云空间。**

如果上面你都没看，那么直接用下面的整合包也是可以的，但是**这里只有 Minecraft 1.12.2 + Forge 2838 版本 + Sponge 2838 版本**，可能会对你想加入的 Mods 带来一些限制。

使用方法（Linux）：

1. 下载该整合包：wget https://timegg.top/wp-content/uploads/2020/04/Minecraft_sponge.tar
2. 解压至任一文件夹，将你想要加入的 Mods 或者插件放到 Mods 文件夹中；
3. 运行 `./lunch_server.sh` 即可运行服务器；

**在连接服务器之前请阅读 4.运行服务器 & 加入 Mods 部分中的注意事项。**

之后在 Windows 上下载 Minecraft 1.12.2 并安装 Forge 2838（不少启动器提供一键式安装），并且确保 Mods 和服务器同步，启动游戏即可连入服务器。

## 结尾

希望 Minecraft 可以给你和伙伴们带来诸多欢乐。