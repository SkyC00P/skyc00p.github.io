
## 安装依赖 ##

```
sudo apt-get update
sudo apt-get install -y curl openssh-server ca-certificates
```

接下来，安装`Postfix`以便可以发送通知邮件。如果想要用其他解决方案来发送邮件，跳过当前一步并请在**GitLab**安装完后配置你自己的SMTP 服务。

```
sudo apt-get install -y postfix
```

安装过程中，可能会出现配置页面。选择`Internet Site`回车并继续。配置一个发件人名字回车并继续。如果有其他配置页面，持续回车选择默认即可。

## 下载安装包并安装 ##

下载脚本并执行
```
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
```

安装**GitLab**安装包，将下面代码的`http://gitlab.example.com`替换成实际的URL，这个地址会作为**GitLab**的入口。安装程序会自动安装，配置并以该URL启动。**HTTPS**需要在安装后额外的配置。

```
sudo EXTERNAL_URL="http://gitlab.example.com" apt-get install gitlab-ee
```

## 浏览登录 ##

```
Thank you for installing GitLab!
GitLab should be available at http://192.168.1.105

For a comprehensive list of configuration options please see the Omnibus GitLab readme
https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/README.md
```

见到上面的显示输出，代表安装完成。之后，第一次使用上面提示的URL登录时会把重定向密码重置页面，如下所示

![](https://i.imgur.com/P3H0QJ4.png)

修改你的代码确定后以`root`的用户登录即可。

具体更多的配置参阅文档 [https://docs.gitlab.com/omnibus/README.html#installation-and-configuration-using-omnibus-package](https://docs.gitlab.com/omnibus/README.html#installation-and-configuration-using-omnibus-package)

