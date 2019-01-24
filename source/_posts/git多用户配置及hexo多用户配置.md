---
title: git多用户配置及hexo多用户配置
abbrlink: 1d6b5022
date: 2019-01-21 03:44:32
categories: 日志
tags: [hexo,git,git多用户]
keywords: git多用户配置
---
## Git配置

Git想要与Github Pages或者Coding pages发生联系,必须有个桥梁,这个桥梁,就是那就是**SSH**与**Git**;

Git配置有这么几种情况,下面分别写一下他们配置方法,针对情况按需配置
<!--more-->

### 单平台单用户更新

对于单平台单用户,配置起来很简单,现在很火的git在线仓库有码云、coding、Github,其实他们原理是一样的,国内Coding和码云比较快.

**1.全局用户信息**

如果是第一次将Hexo 与Github联系起来,我们需要设置username和email，因为github每次commit都会记录它们(只是联系信息,可随意)

```git
git config --global user.name "your_name"	#your_name替换成你的名称
git config --global user.email "your_email@youremail.com"	#后面替换成你的邮箱
```

**2.检测本地是否有SSH KEYS**

```git
ls -al ~/.ssh	#检测电脑是否有SSH KEYS
### 如果提示 No such file or directory证明没有.ssh文件夹
```
> `.ssh`文件默认在Win用户`~/Users/username/`下.  `.ssh`文件夹下有public和private钥匙对（例如id_ras.pub和id_rsa），证明已存在SSH keys。

**3.如果没有SSH KEY，则生成新的SSH KEY**

```git
ssh-keygen -t rsa -C your_email@youremail.com	#改为你的邮箱(联系邮箱)
```

 之后会要求确认路径和输入密码，这里我们默认的一路回车就行。成功的话会在~/下生成 `.ssh` 文件夹

**4.[可省略步骤] ssh-agent管理秘钥**

ssh-agent是一个私钥的管理工具,使用不同的私钥去连接不同的服务器时，需要我们手动输入私钥密码，ssh-agent可以免去这项工作

```git
eval "$(ssh-agent -s)"	#添加密钥到ssh-agent
ssh-add ~/.ssh/id_rsa	#，添加生成的SSH key到ssh-agent
```

**5.与git仓库链接**

与git在线仓库绑定，点击`.ssh`文件，打开 `id_rsa.pub`，复制里面的key，粗暴点就是 Ctrl+a 然后 Ctrl+c,以Github为例(其他大同小异),步骤分别为:

登录Github，右上角 头像 -> `Settings` —> `SSH and GPG keys` —> `New SSH key` 。把公钥粘贴到key中，填好title并点击 `Add SSH key`

**6.验证成功与否**

*验证Github*

```git
ssh -T git@github.com
```
如果是第一次的会提示是否continue，输入**yes**就会看到自己的用户名。这就表示已成功连上github!

*验证coding*

同上，按**yes**就会看到自己的用户名.

> **问题：**假如ssh-key配置失败，那么只要以下步骤就能完全解决
>
> 首先，清除所有的key-pair
> ssh-add -D
> rm -r ~/.ssh
> 删除你在github中的public-key
>
> 重新生成ssh密钥对
> ssh-keygen -t rsa -C "xxx@xxx.com"
>
> 接下来正常操作
> 在github上添加公钥public-key:
> 1、首先将/.ssh/id_rsa.pub公钥中内容复制到剪切板
> 2、在github上添加公钥时，直接复制即可
> 3、保存

**7.修改Hexo站点配置文件(__config.yml)**

```yml
## Docs: https://hexo.io/docs/deployment.html
deploy:
  type: git
  repository: git@github.com:YourName/YourName.github.io.git	#git ssh地址
  branch: master
```

### 多平台同步更新

这里多平台单用户是指:只在Github或者Coding上只注册一个用户,想要同步更新,下面以Hexo+github+coding双线博客为例,使用**同一个秘钥**就可以了,现在分享大概步骤

**1.登录或注册coding**

有账户登录,没有账户直接搜索注册

**2.Coding添加SSH Key(无须重新生成)**

复制已经生成好的`id_rsa.pub`中的密匙,登上Coding，登录进入主页，点击 `账户` —> `SSH公钥` —> 输入key再点击 `添加`

*验证ssH Key*

```git
ssh -T git@git.coding.net	#选输入 yes 回车看到用户名说明链接成功了 
```

*创建仓库*

仓库命名的格式建议为**{user_name}.github.io**，

*设置hexo分支(如果不想博客源码,以及md源文件备份,可以省略这步骤)*

在**{user_name}.coding.me**仓库下,点击`代码` —> `分支管理` —> `新建分支` —>创建名为 `hexo` 分支 —>点击 master后面的 `修改默认分支` 设置 hexo 为默认分支

*开启Pages 服务,获取SSH*

点击`代码`—>`Pages服务` —>`静态pages`—>部署来源:`master 分支`   ,然后获取 **SSH**

**3.hexo 站点配置文件(__config.yml)修改**

```yml
# Deployment
## Docs: https://hexo.io/docs/deployment.html
deploy:
  type: git
  repo:
    github: git@github.com:your_name/your_name.github.io.git
    coding: git@git.coding.net:your_name/your_name.github.io.git
  branch: master
```

### 单平台多用户不同步更新

例如github,平常有一台电脑, 多个github帐号的SSH key切换, 更新多个hexo博客

> 这里默认你本地已经有一个`id_rsa.pub`了,如果在有一个github账号,该如何创建密匙更新hexo博客呢?

**1.创建.ssh文件**

判断有没有`.ssh`文件

```git
cd ~/.ssh/	#进入.ssh文件夹,如果提示No such file or directory则需重新创建
####如果有的话, 至少有id_rsa、 id_rsa.pub这两个文件(说明安装过,无所谓,也可以按照以下的步骤安装)
```
如果没有,开始创建.ssh文件

```git
cd ~
mkdir .ssh
```

**2.创建新的 私钥/公钥, 并指定秘钥名称:standbyme_id_rsa**

进入`.ssh`根目录

```git
cd ~/.ssh
```

<span style="color:red;">(操作方法一)</span>使用一行命令行, 然后两次回车即可

```git
ssh-keygen -t rsa -f  ~/.ssh/随便名字_id_rsa -C "yourmail@xxx.com"
```
<span style="color:red;">(操作方法二)</span>使用下面命令建秘钥, 需要三次回车, 但是第一次回车需要输入秘钥名字.

```git
ssh-keygen -t rsa -C "yourmail@xxx.com"
```
![安装选项第一个回车要填写秘钥名称](https://wx4.sinaimg.cn/large/006cjkx2ly1fzbon6hhc0j30hy097t94.jpg)

注意:这次创建新的秘钥 ,不要再三次回车了, 要在第一次回车的地方,填入新秘钥名字, 如果不填将使用默认的id_rsa , 会将原来的ssh_key覆盖. 新秘钥名后面建议加<span style="color:red;">_id_rsa</span>

![安装完示例](https://wx1.sinaimg.cn/large/006cjkx2ly1fzbott57rxj30gw07g74i.jpg)

**3.配置config**

如果 `~/.ssh/`根路径下, 没有config, 则创建一个config文件

```git
touch config
```

config配置如下, 第一个为原来的ssh key配置, standbyme为新的ssh key配置

```txt
#第一个账号，默认使用的账号
Host github.com
 HostName github.com
 User git
 IdentityFile ~/.ssh/id_rsa
# 第二个账号 standbyme
Host standbyme.github.com # standbyme为前缀名，可以任意设置
 HostName github.com
 User git
 IdentityFile ~/.ssh/standbyme_id_rsa
```

> 原理分析:
>
> 1.ssh 客户端是通过类似 git@github.com:githubUserName/repName.git 的地址来识别使用本地的哪个私钥的，
>  地址中的 User 是@前面的git， Host 是@后面的github.com。
>
> 2.如果所有账号的 User 和 Host 都为 git 和 github.com，那么就只能使用一个私钥。
>  所以要对User 和 Host 进行配置，让每个账号使用自己的 Host，每个 Host 的域名做 CNAME 解析到 github.com，
>  如上面配置中的Host standbyme.github.com。
>
> 3.配置了别名之后，新的地址就是git@standbyme.github.com:githubUserName/repName.git。
>  这样 ssh 在连接时就可以区别不同的账号了。

**4.设置新<span style="color:red;">github</span>账户SSH key**

a打开用户目录，找到.ssh\standbyme_id_rsa.pub文件，记事本打开并复制里面的内容，打开你的github主页，进入个人设置 -> SSH and GPG keys -> New SSH key：

![添加新的SSH Key](https://ws1.sinaimg.cn/large/006cjkx2ly1fzdecm7zeaj30so0bi74z.jpg)

将刚复制的内容粘贴到key那里，title随便填，保存。

**5.在.ssh根目录下, 清空本地的 SSH 缓存，添加新的 SSH 密钥 到 SSH agent中**

开启agent

```git
eval "$(ssh-agent -s)"
```

进入.ssh文件夹先清除agent所有账户,然后重新添加

```git
cd ~/.ssh
ssh-add -D
ssh-add id_rsa
ssh-add standbyme_id_rsa
```
最后确认一下新秘钥已经添加成功

```git
ssh-add -l
```

**6.输入指令,验证配置是否成功**

*默认ssh_key验证*

```git
ssh -T git@github.com
```

*新ssh_key验证, 新秘钥名替换username*

```git
ssh -T git@username.github.com
```

<span style="color:red;">(注意)</span>如果提示如下信息, 则配置成功

`Hi yourname! You've successfully authenticated, but GitHub does not provid`

**7.进入各自项目文件夹，单独设置用户名/邮箱**

*注意：如果有多个账号，建议使用局部的。*

```git
# 取消全局 用户名/邮箱 配置
git config  --global --unset user.name
git config  --global --unset user.email

# 单独设置每个repo 用户名/邮箱,进入到.git文件夹
git config user.name "your_name"  //在config后加上--global即全局
git config user.email "your_email@youremail.com"
```
第二种单独为项目配置的方法(全局和单独配置都存在的时候会默认使用项目单独配置的)：

1.打开项目所在目录，找到隐藏的.git文件夹。注意这个文件夹是隐藏的，显示隐藏出来就行。

2.打开文件夹里的config文件，用记事本打开。

3.添加这三行到文件：

[user]
    name = XXX(自己的名称)
    email = XXXX(邮箱)

```git
git config --list	#	q!	强制退出,不保存
```

**8.最后在 hexo 配置文件修改git地址**

```yml
deploy:
  type: git
  repository: git@username.github.com:githubUserName/githubUserName.github.io.git
  branch: master
```

**9.配置多个git**

配置多个git账户重复以上步骤。


### 多平台多用户不同步更新

在不同平台管理git,其实这个与**单平台多用户不同步更新** 差不多,多的就是文件夹管理公钥

操作演示用github和Coding账号

**1.`.ssh`目录下,创建coding和github文件夹**

```git
cd ~/.ssh
mkdir github
mkdir coding
```

![创建两个coding 和github 文件夹](https://wx4.sinaimg.cn/large/006cjkx2ly1fzdj3fuaadj309c04ojrc.jpg)

**2.本地SSH公钥**

进入不同的文件夹创建公钥

```git
cd ~/.ssh/github
ssh-keygen -t rsa -C your_email@youremail.com	#替换你的邮箱
```
> 创建默认只需要三步回车,创建多个的时候要在第一个回车处填写名称,例如yourname_id_rsa

**3.分别把对应的*id_rsa.pub中的内容复制到对应的平台**

打开对应的平台,找到对应的*id_rsa.pub中的内容复制到对应的平台

**4.配置config**

如果 `~/.ssh/`根路径下, 没有config, 则创建一个config文件

```git
touch config
```

config配置如下, 第一个为原来的ssh key配置, standbyme为新的ssh key配置

```txt
#第一个账号，github
Host github.com	#如果是多账号yourname.github.com
 HostName github.com
 User git
 IdentityFile ~/.ssh/github/id_rsa
# 第二个账号 coding
Host git.coding.net # 如果是多账号yourname.git.coding.net
 HostName git.coding.net
 User git
 IdentityFile ~/.ssh/coding/id_rsa
```

> 原理分析:
>
> 地址中的 User 是@前面的git， Host 是@后面的github.com。

**5.在.ssh根目录下, 清空本地的 SSH 缓存，添加新的 SSH 密钥 到 SSH agent中**

开启agent

```git
eval "$(ssh-agent -s)"
```

进入.ssh文件夹先清除agent所有账户,然后重新添加

```git
cd ~/.ssh	#进入.ssh文件夹
ssh-add -D	#清除agent保存的所有公钥,这步很重要,如果不做或默认缓存ssh
ssh-add ~/.ssh/github/id_rsa
ssh-add ~/.ssh/coding/id_rsa
```

最后确认一下新秘钥已经添加成功

```git
ssh-add -l
```

**6.输入指令,验证配置是否成功**

*github验证*

```git
ssh -T git@github.com
```

*coding验证*

```git
ssh -T git@git.coding.net
```

<span style="color:red;">(注意)</span>如果提示如下信息, 则配置成功

`Hi yourname! You've successfully authenticated, but GitHub does not provid`

**7.进入各自项目文件夹，单独设置用户名/邮箱**

*注意：如果有多个账号，建议使用局部的。*

```git
# 取消全局 用户名/邮箱 配置
git config  --global --unset user.name
git config  --global --unset user.email

# 单独设置每个repo 用户名/邮箱,,进入到项目的.git文件夹下执行
git config user.name "用户名"  //在config后加上--global即全局
git config user.email "邮箱"
```

*查看配置是否成功*

```git
git config --list
```

**8.最后在 hexo 配置文件修改git地址**

```yml
deploy:
  type: git
  repository: git@username.github.com:githubUserName/githubUserName.github.io.git
  branch: master
```

**9.配置多个git**

配置多个git账户重复以上步骤。