---
title: "哈恩巴拿赫定理证明"
date: 2019-02-10T00:00:00+09:00
hidden: false
draft: false
tags: ["教程文档"]
summary: "Hahn-Banach Theorem 哈恩巴拿赫定理被称为泛函分析三大定理之一，是泛函分析中极其重要的一个工具。在经济学领域，该定理与市场经济的福利经济学第二定理有密切的关系。关于这个定理证明的资料在网上可以搜索到的不多，大多为应用，因此在这里展示对该定理的证明。"
author: "Chuanbo"
count: "1227 Words"
---

过年在家出于兴趣阅读了一些金融相关的书籍，其中提到了很多数学原理，作为一个数学系的学生，我觉得非常的有趣，感受到了数学在真实生活中的应用。

在这些内容中，有一部分涉及到了我在上一个学期在泛函分析中的一个定理：[Hahn-Banach Theorem(English)](https://en.wikipedia.org/wiki/Hahn%E2%80%93Banach_theorem) 即 [哈恩-巴拿赫定理(中文)](https://zh.wikipedia.org/wiki/%E5%93%88%E6%81%A9%EF%BC%8D%E5%B7%B4%E6%8B%BF%E8%B5%AB%E5%AE%9A%E7%90%86) 。这个定理被称为泛函分析三大定理之一，是泛函分析中极为重要的一个工具。在经济学中 Hahn-Banach Theorem 与市场经济的福利经济学第二定理有着密切的关系。

在假期中想到这个定理，但是记不得定理的证明了，在 Google 上搜索了许多，但是关于这个定理的中文资料很少，而且大部分都是定理的应用。于是回到学校之后参考老师的讲义，将这个定理的证明记录下来。并不是说我自己对掌握这个定理的证明有多大的执念，只是想留下这一篇 Post 来提示自己好好学习数学，诸多学科都会要求一定的数学功底。

# 正文

*引理*&emsp; 设 $f$ 是赋范空间 $X$ 上的有界泛函，令 $\varphi (x)=Ref(x)$ ，则 $\varphi (x)$ 是 $X$ 上的有界线性泛函且 

$$f(x)=\varphi (x)-i\varphi (ix), || \varphi ||\le ||f||.$$

**证明**&emsp; 设 $f(x)=\varphi (x)-i\psi (ix)$ ，这里 $\varphi (x), \psi (x)$ 分别是 $f(x)$ 的实部与虚部。显然 $\varphi , \psi$  是实线性泛函。

$$\varphi (ix)+i\psi (ix)=f(ix)=if(x)=i\varphi (x)-\psi (x).$$

故 

$$\varphi (ix)=-\psi (x)$$

因此 

$$f(x)=\varphi (x)-i\varphi (ix).$$

$$|\varphi (x)|=|Ref(x)|\le |f(x)|\le ||f||||x||$. 故 $||\varphi||\le ||f||.$$

*定理*&emsp; 设 $M$ 是线性空间 $X$ 的子空间，$f$ 是 $M$ 上的线性泛函，$p$ 是 $X$ 上的半范数，对 $x\in M$，有 $|f(x)|\le p(x)$，则 $f$ 可以延拓为 $X$ 上的线性泛函 $F$ 且对任意 $x\in X$，有 $|F(x)|\le p(x)$.

**证明**&emsp; 若标量域 $\mathbb{K}=\mathbb{R}$ ，由于 $p$ 是次可加正齐次泛函，故存在 $F$ 是 $X$ 上的线性泛函，是 $f$ 的延拓.

则 

$$-p(x)=-p(-x)\le -F(-x)=F(x)\le p(x)$. 故 $|F(x)|\le p(x).$$

若标量域 $\mathbb{K}=\mathbb{C}$ ，令 ${\varphi}_0=Ref$ 是 $M$ 上的实线性泛函且 $||{\varphi}_0||\le |f(x)|\le p(x)$. 故存在 ${\varphi _0} $在 $X$ 上的延拓 $\varphi$ ，使得 $\varphi (x)\le p(x)$.

作 $F(x)=\varphi (x)-i\varphi (ix)$ ，则 $F$ 是 $f$ 在 $X$ 上的延拓且复线性泛函：

$$F(ix)=\varphi (ix)-i\varphi (-x)=iF(x).$$

由于存在单位复数 $\beta$ ，使得 $|F(x)|=\beta F(x)$. 故

$$|F(x)|=\beta F(x)=F(\beta x)=\varphi (\beta x)\le p(\beta x)=|\beta|p(x)=p(x).$$

*定理*&emsp; 设 $G$ 是赋范空间 $X$ 的线性子空间，$f$ 是 $G$ 上的有界线性泛函，则存在 $X$ 上的线性泛函 $F$ 是 $f$ 的延拓且 $||F||=||f||$.

**证明**&emsp; 记 $p(x)=||f||·||x||$ 是 $X$ 上的半范数且 $|f(x)|\le p(x)$. 故存在 $X$ 上的线性泛函 $F$ 是 $f$ 的延拓，使得 $|F(x)|\le p(x)=||f||·||x||$. 故 $||F||\le ||f||$.

显然

$$||F||=sup_{x\ne 0}\frac{|F(x)|}{||x||}\ge sup_{G\ni x\ne0}\frac{|f(x)|}{||x||}=||f||.$$

故 $||F||=||f||$.

*定理*&emsp; 设 $G$ 是赋范空间 $X$ 的线性子空间，$x_0 \in X$，$d\triangleq inf_{f\in G}||x_0-y||>0$，则存在 $f\in X^*$，使得对 $x\in G$，有 $f(x)=0; f(x_0)=d; ||f||=1$.

**证明**&emsp; 显然 $x_0\notin G$. 记 $G_1={\alpha x_0 + x\ |\ x\in G, \alpha \in \mathbb{K}}$ 是线性子空间。

作 $g:G_1\ni \alpha x_0 + x\mapsto \alpha d\in \mathbb{K}$ 是线性泛函。

对 $x\in G$，有 $g(x)=0; g(x_0)=d$;

$$|g(\alpha x_0+x)|=|\alpha|d\le |\alpha|·||x_0-(-x)/\alpha||=||\alpha x_0+x||$$

故 

$$||g||\le 1$$

$$d=g(x_0)=g(x_0-x)\le ||g||||x_0-x||$$

故

$$d\le ||g||inf_{x\in G}||x_0-x||=||g||d$. 故 $1\le ||g||$$

因此 $||g||=1$. 

存在 $g$ 的延拓 $f\in X^*$，使得 $||f||=||g||=1$. 

**推论**&emsp; 设 $X$ 是赋范线性空间，$x_0\in X, x_0 \ne 0$，则存在 $f\in X^*$，使得 $f(x_0)=||x_0||$ 且 $||f||=1$.

**推论**&emsp; 设 $X$ 是赋范线性空间，$x\in X$，则 $||x||=sup_{f\in X^*}\frac{|f(x)|}{||f||}$.

# 其他

泛函分析在经济学中的应用很广泛，更多内容可以参考知乎的问题 https://www.zhihu.com/question/31913447/answer/53821730。