---
layout:     post
title:      使用 Python 爬取 Vol.moe 资源
subtitle:   实现批量下载 Vol.moe 漫画
date:       2018-07-25
author:     HuaChuanbo
header-img: img/post-bg-volmoe.jpg
catalog: true
tags:
    - Python
---

> 实际上是一个超简单的东西，为什么非得拿来写 Blog 呢？ <br> ——  因为这个网站真的很不错所以我来安利来了~

之前在寻找一些漫画资源的时候，偶然遇到了这个漫画网站：[Vol.moe](https://vol.moe/)

![Vol.moe](https://vol.moe/img/vollogo.png)

网站上提供了相当全的漫画资源和下载，并且质量比较有保证。在网上漫画资源比较零碎的环境下非常方便。

Vol.moe 提供普通用户限量限速下载，初期我对漫画需求量比较大，准备一次性大量下载回头慢慢看，于是捐助成为了会员，开始了一本一本漫画的下载。

令人可惜的是网站明确指出：

> Q4: 為什麼沒有批量下載與全選推送？<br> A4: 本站帶寬有限，所以不鼓勵批量下載和全選推送，希望大家準備看的書才下載。如果確實需要批量，請尋找支持批量下載的下載軟體吧。

所以面对 *One Piece* 、*火影忍者* 、*银魂* 等等动辄八九十卷的下载连接，实在是没有耐心一个一个点下去，所以想到用 Python 写一个小爬虫爬漫画。

**引入 Pack 、填写用户变量**

```
from urllib import parse
from bs4 import BeautifulSoup
import urllib.request
import urllib.error
import chardet
import http.cookiejar

login_url = 'https://vol.moe/login_do.php'
url = "https://vol.moe/comic/*****.htm" // 爬取相应网页的链接

values = {
    "email": "**********@gmail.com",
    "passwd": "********",
    "keepalive": "on",
}
```

**用户身份登陆，获取 Cookies**

**2019.3.10 Update** - Chrome 上有非常好用的 Cookies 插件，支持直接导出 Cookies 文件，如果觉得这部分比较繁琐，可以手工登陆之后 Download 自己的 Cookies，从而省下这一步。

```
data = urllib.parse.urlencode(values).encode(encoding='UTF-8')
user_agent = '*********' // 浏览器记录信息
headers = {'User-Agent': user_agent, 'Connection': 'keep-alive'}

cookie_filename = 'vol_cookie.txt' // Cookies 保存文件名
cookie_aff = http.cookiejar.MozillaCookieJar(cookie_filename)


handler = urllib.request.HTTPCookieProcessor(cookie_aff)
opener = urllib.request.build_opener(handler)

request = urllib.request.Request(login_url, data=data, headers=headers)
try:
    response = opener.open(request)
except urllib.error.URLError as e:
    print(e.reason)

cookie_aff.save(ignore_discard=True, ignore_expires=True)
for item in cookie_aff:
    print('Name ='+ item.name)
    print('Value ='+ item.value)
```

**抓取用户登陆网页**

```
import urllib.request, urllib.parse
import http.cookiejar

get_url = 'https://vol.moe/comic/10243.htm'
cookie_filename = 'vol_cookie.txt'
cookie_aff = http.cookiejar.MozillaCookieJar(cookie_filename)
cookie_aff.load(cookie_filename, ignore_discard=True, ignore_expires=True)

handler = urllib.request.HTTPCookieProcessor(cookie_aff)
opener = urllib.request.build_opener(handler)

# 使用cookie登陆get_url
get_request = urllib.request.Request(get_url)
get_response = opener.open(get_request)
print(get_response.read().decode())
```

其实直接在网页登陆后，打开相应漫画下载页面 f12 拿到的就是包含所有下载链接的 html ，这个网站的链接不是 Php 单独对话，直接筛选就很方便。不过现在这样做更省后来的事，还能做一个 exe 出来。

上面抓取 html 之后筛选，search ‘下载epub’ 所有的 \<a> 自带链接，抓出来之后就能批量下载了。

不过很值得注意的是，Vol.moe 有如下说明：

>Q5: 下載線路速度限製及IP限製的問題。 <br>A5: 本站帶寬有限，為防止無序無限製的下載，故已經對下載進行了速度限製、IP校驗與限製 <br>\* 同一IP同時下載線程不能超過3個，\*\*\* 部分瀏覽器/工具在線程被限製後整個下載任務會失敗 \*\*\*，遇此情況請修改設置，或使用Chrome瀏覽器。 <br>\* 部分瀏覽器或下載工具會使用多線程下載，將會被視為多文件同時下載，達到限製後會需要等待較長時間才會解除限製。 

使用下载工具下载还是要控制一下线程，防止被屏蔽。Vol.moe 服务器位于北美，网站注册于 TW ，下载速度在大陆感觉还是很不稳定，不知道跟网站审查下行流量有关系没有。（结果一天下载了 20G 被限速到 100k www）

以上。