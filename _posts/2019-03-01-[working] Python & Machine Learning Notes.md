---
layout:     post
title:      Python & Machine Learning Notes
subtitle:   使用 Python 学习机器学习
date:       2019-03-01
author:     HuaChuanbo
header-img: img/bg_img/machine_learning.jpeg
catalog: true
tags:
    - Python
    - Machine Learning
    - Notes
---

---

IDE: Pycharm Build #PC-171.4694.67

Python Version: 3.5.0

Matplotlib Version: 3.0.2

---

## Summary

### Python

装饰器不是很懂

Python 中任何模块代码的第一个字符串都被视为模块的文档注释

`__author__`变量把作者写进去：

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

' a test module '

__author__ = 'Magic_kurakun'

import ...
```

Python 在写类的时候常用 `@property` `@score.setter` 来实现函数重构效果

~~向死而行的生命都在热烈地生长~~

高级编程出现 bug 时，**异常栈**是最主要的解决方案

~~调试程序的时候善用断言 `assert~~`

`logging` 强大的功能（调试的终极神器）

```python
import logging
logging.basicConfig(level=logging.INFO)
# debug，info，warning，error
```

**关于使用 docx 出现 No module named ‘exceptions’  问题的结局方案**

pip install docx 
完了之后，导入：import docx 
发现报错：ModuleNotFoundError: No module named ‘exceptions’ 
说没有 exceptions 这个模块，由于Python3已经取消了这个模块，而 PendingDeprecationWarning 是内置 
可以直接使用的，所以我们直接进入文件（这个要看你报错显示的路径）： 
D:\ProgramFiles\Anaconda3\lib\site-packages\docx.py 

把 from exceptions import PendingDeprecationWarning 注释掉即可

https://blog.csdn.net/a649344475/article/details/81162381





### Tensorflow 基础框架

从最基础的 Hello World 来了解 Tensorflow 的框架

```python
import tensorflow as tf
import numpy as np

# create data
x_data = np.random.rand(100).astype(np.float32)  # most type in tensorflow is float32
y_data = x_data * 0.1 + 0.3

# create tensorflow structer start
# create y function (.Variable)
Weights = tf.Variable(tf.random_uniform([1], -1.0, 1.0))
biases = tf.Variable(tf.zeros([1]))
y = Weights * x_data + biases

# cal the error
loss = tf.reduce_mean(tf.square(y - y_data))

# transfer error (Gradient Descent Optimizer method)
optimizer = tf.train.GradientDescentOptimizer(0.5)  # 0.5-learning efficiency
train = optimizer.minimize(loss)  # reduce error

init = tf.global_variables_initializer()  # init such variables
# create tensorflow structer end

sess = tf.Session()
sess.run(init)  # pointer

for step in range(101):
    sess.run(train)
    if step % 20 == 0:
        print(step, sess.run(Weights), sess.run(biases))
```

先完成一边之后再慢慢理解其中的各种函数的意义。

在 TensorFlow 中，数据不是以整数，浮点数或者字符串形式存在的，而是被封装在一个叫做 tensor 的对象中

`Session` - Tensorflow 控制 & 输出文件的执行的语句，运行 `session.run()` 可以获得你要得知的运算结果, 或者是你所要运算的部分。在运行此语句之前，所有的代码块仅为模块，并没有参与运算

```python
with tf.Session() as sess:
	output = sess.run(hello_constant)
```

![img](C:\Users\huama\Desktop\20170615230801152.png)

`Variable `- 不同于 Python，Tensorflow 中定义了某字符串是变量它才是变量；`value_name = tf.Variable()`，而且在有了各变量的定义之后还需要初始化 `init = tf.initialize_all_variables()` 并且在初始化各变量之后还需要激活 `sess.run(init)`

`print` 变量时，需要将 `Session` 指针指过去才能输出的出来，ex. `print(sess.run(value_name))`

激励函数 - $$y=AF(Wx)$$ 可用来解决线性方程无法解决的问题



### 创建神经网络的流程

1. 创建 add_layer 函数来提供添加层的功能
2. 创建数据（导入数据）
3. 搭建网络：
   - 输入层：控制数据输入
   - 隐藏层：神经元所在层次
   - 输出层：控制数据输出
4. 开始训练



### 加速神经网络

如果可以，最好看看数学推理

- Stochastic Gradient Descent (SGD)： 将数据拆分之后分部放入神经算法中计算；速度在这几种算法中是比较慢的一种
- Momentum
- AdaGrad
- RMSProp
- Adam

![img](https://morvanzhou.github.io/static/results/ML-intro/speedup3.png)

总之就是，在加速神经网络训练的时候, 一个下坡, 一双破鞋子, 功不可没。

### 优化器的选择

Tensorflow 提供了 7 种优化器......

### 可视化

**神经网络可视化**

Tensorboard 可以很方便的实现神经网络可视化，其效果大概是这样的

![img](https://morvanzhou.github.io/static/results/tensorflow/4_1_1.png)

~~但是实现起来好麻烦啊~~（看起来比较麻烦）实际上的差别就在于把定义变量的部分从直接用 `Variable` 换成了`with tf.name_scope('图层名称')` 这样

**数据变化可视化**

```python
 tf.summary.histogram(layer_name + '/weights', Weights) # tensorflow >= 0.12
```

常用 hisrogram_summary 进行数据可视化图表绘制， 第一个参数是图表的名称, 第二个参数是图表要记录的变量。整体上用法就是在定义变量之后的一行将这个变量记录下来，指明准备以此变量画图表。



整体上神经网络遇到的问题是有拟合问题与分类问题之分的

卷积神经网络常常用在计算机图像识别、视频分辨等等计算机视觉方面



### 卷积神经网络

卷积神经网络包含输入层、隐藏层和输出层，隐藏层又包含卷积层和`pooling`层，图像输入到卷积神经网络后通过卷积来不断的提取特征，每提取一个特征就会增加一个`feature map`，



## Thingking

- numpy 和 panda 部分可以在后面的学习中现场理解，个人认为不用看这一部分教程，回头有看不懂的地方返回来翻或者 Google 都可以
- 借用鸟哥的一句话，我的忘性是远大于记性的，所以我将我做过的、学过的很多东西都记在这个地方，有需要的时候回来看看，能很快的会想起来



## 遇到的问题

- Pycharm Pip 安装和 Project Interpreter 之间有什么奇怪的关系？至今依然是迷迷糊糊
- Pycharm  的项目管理，Project 下有 Dictionary，再下是文件，有没有规范的管理方式，命名规则
- 如何在 Linux 敲代码？ Linux 安装各种插件都是相当的方便，几乎都是一句代码就完成了，这个与 Linux 生态是相关的吗？