---
title: hexo github博客的搭建
abbrlink: 4f8603fa
date: 2019-01-21 02:44:32
categories: 日志
tags:
  - hexo
  - github
keywords: hexo,hexo github
---

今天教一下大家利用`Hexo` + `Github Pages`搭建免费博客,好了教程开始

## 环境搭建

开始前要搭建本地环境,以Windows操作系统为例(因为穷啊 买不起Mac) ,首先要准备要安装的软件
<!--more-->

**1.Git**

去<a href="https://www.git-scm.com/download/"  target="_blank" rel="nofollow">git官网</a>上下载对应的版本 ,git操作,可以去google学习一下;

**2.Node.js**

去<a href="https://nodejs.org/en/"  target="_blank" rel="nofollow">node.js官网</a>下载LTS稳定版本,一路撸键盘选择安装.

**3.Markdown编辑器**

hexo会吧本地的`.md`文档转化成静态文件, md语法很简单,学习10分钟足够入门和使用,这里作为一个半新手给大家推荐一款编辑器 <a href="https://www.typora.io/" target="_blank" rel="nofollow" >typora</a> 推荐理由主要是跨平台,使用起来无阻碍

## git配置

Git想要与Github Pages或者Coding pages发生联系,必须有个桥梁,这个桥梁,就是那就是**SSH**与**Git**;

Git配置有这么几种情况,下面分别写一下他们配置方法, <a href="https://standbyme.io/posts/1d6b5022.html" target="_blank" rel="nofollow">git多用户配置及hexo多用户配置针对情况按需配置</a>

## Github仓库

这里用github实现两个目的,第一利用node.js+hexo 生成网站并托管在github pages上,第二方便备份和重新搭建,基于这两个目标,找了很多资料,下面我基于你已经有github账号了,没有的可以重新注册一下 <a href="https://github.com" target="_blank" rel="nofollow">here</a>…

**1.仓库命名**

在github 上创建仓库名,格式必须是`username.github.io` 其中\username是你github的用户名

**2.创建分支**

在你新创建的`username.github.io` 仓库中创建新的分支**hexo** 其中hexo仓库主要保存博客源文件,静态文件会在**master**分支中 ,并默认分支为**hexo**

该仓库步骤: create branch: `hexo`—>settings—>branches—>Default branch: `hexo`—>update

## Hexo安装

想要在github pages 完美更新和源代码备份,建议按照以下步骤进行

**1.clone仓库**

先把github的仓库clone到本地,在适合的位置clone 你的`username.github.io` 在`git`中做如下操作

```
git clone https://github.com/username/username.github.io.git  #username为你用户名
```

这样就把github的仓库克隆到本地了

**2.本地仓库内容备份**

克隆岛本地仓库之后,打开`username.github.io`命名的文件夹,其中有内容`.git`等等全部剪切保存起了,装完博客后再放进去(hexo init会初始化内容,删掉文件夹中的东西),如若看不到`.git`等系列文件,只能说明一个问题,电脑**文件夹选项**中隐藏了……

**3.博客安装**

(大国用户专属)大国地区用户需要安装淘宝nmp源,安装代理源之后,`npm`命令全部用`cnpm`命令代替;VPN用户请忽略 ,代理源代码为:

```
npm install -g cnpm --registry=https://registry.npm.taobao.org #大国用户之后专用cnpm
```

hexo安装代码:

```
npm install hexo -g		#大国用户用cnpm
```

hexo初始化:

```
hexo init	#初始化文件夹,hexo init之后就可以把之前仓库文件放进去了
```

hexo依赖包:

```
hexo install	#同样大国用户用cnpm
```

> win用户如果这个会报错,可以试试以下命令
>
> npm install –no-optional

预览和结束:

```
hexo s 	#本地访问 http://localhost:4000/ 本地实时预览

ctrl+c	#关闭预览
```

hexo部署插件:

提供了快速方便的一键部署功能，让您只需一条命令就能将网站部署到服务器上

```
npm install hexo-deployer-git --save	#必须装
```

> 注意:部署插件安装之后,要修改`站点配置文件`(_config.yml)中修改

```
deploy:
  type: git
  repo: git@github.com:username/username.github.io.git
```

## Hexo命令

使用hexo必须要了解,常用的命令,这样操作起来你知道干嘛的

```
hexo n "title"		#创建一篇文章

hexo new page "guestbook"	#创建一个名为guestbook的自定义页面

hexo clean	#清除缓存

hexo s	#本地预览

hexo g	#生成静态文件

hexo d	#部署到服务器上
```

## Hexo日常修改

在本地对博客进行修改（添加新博文、修改样式等等）后，通过下面的流程进行管理：

1. 依次执行`git add .`、`git commit -m "…"`、`git push origin hexo`指令将改动推送到GitHub（此时当前分支应为**hexo**）；
2. 然后才执行`hexo g -d`发布网站到master分支上。

虽然两个过程顺序调转一般不会有问题，不过逻辑上这样的顺序是绝对没问题的。

## Hexo资料丢失

当重装电脑之后，或者想在其他电脑上修改博客，可以使用下列步骤：

1. 使用`git clone git@github.com:username/username.github.io.git`拷贝仓库（默认分支为hexo）；
2. 在本地新拷贝的username.github.io文件夹下通过Git bash依次执行下列指令：`npm install -g hexo`、`npm install`、`npm install hexo-deployer-git --save`（注意，不需要hexo init这条指令）。

## Hexo主题

默认主题,不让人喜爱这是很正常的事情,也许hexo的设计者当时只顾着完善功能,装修的事情没太多时间去做.可以在Hexo官网挑选自己喜欢的[Themes](https://hexo.io/themes/)

> 注意:不管是默认主题还是自定义主题,主题文件夹中的`.git`一定要删除,否则主题文件夹push不上去

## Hexo常用插件推荐

有些另类功能要通过插件实现,插件让hexo更强大,下面推荐几个插件

**1.站点xml地图**

```
npm install hexo-generator-sitemap --save #sitemap.xml适合提交给谷歌搜素引擎
npm install hexo-generator-baidu-sitemap --save #baidusitemap.xml适合提交百度搜索引擎
```

修改`主题配置文件` (_config.yml)

```
#sitemap自动生成
sitemap:
	path: sitemap.xml
baidusitemap:
	path: baidusitemap.xml
```

**2.URL唯一性插件**

hexo 站点URL永久链接方案以及URL唯一性是我一直头疼的问题,直到一天我看到一个方案,欣喜若狂,感谢[作者](https://github.com/Rozbo/hexo-abbrlink)

```
npm install hexo-abbrlink --save
```

完成之后修改`站点配置文件`

```
permalink: posts/:abbrlink.html
abbrlink:
	alg: crc32  # 算法：crc16(default) and crc32
	rep: hex    # 进制：dec(default) and hex
```

**3.站点robots.txt**

新建robots.txt文件，添加以下文件内容，把robots.txt放在hexo站点的source文件下

```
#hexo robots.txt
User-agent: *
Allow: /
Allow: /archives/

Disallow: /vendors/
Disallow: /js/
Disallow: /css/
Disallow: /fonts/
Disallow: /vendors/
Disallow: /fancybox/

Sitemap: https://StandByMe.io/sitemap.xml
Sitemap: https://StandByMe.io/baidusitemap.xml
```

**4.未完待续**

好插件推荐给我我就更新了,可以推荐给我……

