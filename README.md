> anthor  : zyl   
> e-mail  : zhaoyulai@inspur.com    
> date    : 2019-08-15  
> version : 1.0.0   

## 介绍

自动化部署 OpenStack 脚本是通过 [shell](http://c.biancheng.net/view/706.html) 脚本语言编写，实现一键搭建 [OpenStack Rocky](https://docs.openstack.org/rocky/index.html) 版本的运行环境和服务。该脚本程序在 Ubuntu 18.04 系统上测试并运行，其它版本不能保证正常运行，整个脚本编写参考了 [OpenStack官方文档](https://docs.openstack.org/install-guide/) 以及 [Rocky版本部署、集成ODL](https://note.youdao.com/ynoteshare1/index.html?id=88344e82328a0435177737ea04888424&type=note)，编写该脚本的目的是不仅仅学习 OpenStack 的环境配置和服务部署，更重要的是理解 OpenStack 的架构，同时也方便了日常搭建服务节点的工作。



## 提示

搭建 OpenStack 的服务需要下载很多软件包，因此在部署之前需要保证网络畅通，Ubuntu 的网络配置可以参考 [network](http://note.youdao.com/noteshare?id=7939e2c10c749306229eb4165ac535ec&sub=88A42FE1BF3549C8A2D77DA81C99BDFF),
**最好**先提前更新和下载相关软件包，下载软件包需要花很多时间，请耐心等待，若一次下载不成功可多次尝试。

ps: 还有几个服务部署还未测试，尝试有惊喜（滑稽）

## 功能

该脚本可以安装部署以下几种服务：

- Mysql
- Rabbitmq
- Etcd
- OpenStack
- Keystone
- Glance
- Nova
- Neutron
- Ironic
- ODL

## 使用
使用该脚本依赖两个文件：配置文件 `stack.conf` 通用函数 `src/funtion-common`

> 修改配置
> ```sh
> # 进入该目录
> cd auto-deploy-openstack
> # 查看配置
> vim stack.conf
> # 每个服务对应一个 section
> # 修改将部署某服务所在的 HOST 或者 IP
> # 以及对应的用户和密码即可
> ```

> 使用脚本
> ```sh
> # 进入该目录
> cd auto-deploy-openstack
> 
> # 运行前请赋予该文件`deploy.sh`执行权限
> chmod +x deploy.sh
> 
> # 执行以下指令
> ./deploy.sh [--help] [服务...]
> 
> #----------------------------------------------------------
> #   --help:                            查看帮助
> #
> #   服务：
> #        keystone                      身份认证
> #        glance                        镜像服务
> #        nova_controller               计算服务（controller）
> #        nova_compute                  计算服务（compute）
> #        neutron_controller            网络服务（controller）
> #        neutron_compute               网络服务（compute）
> #        ironic                        裸金属
> #        odl_controller                ODL（controller）
> #        odl_compute                   ODL（compute）
> #        mysql                         数据库
> #        rabbitmq                      消息队列
> #        openstack                     OpenStack
> #        etcd                          键值存储
> #        installationSource            替换镜像源
> #
> #   示例：
> #       安装部署 keystone ：
>         ./deploy.sh keystone
> #       安装部署 Mysql etcd rabbitmq：
>         ./deploy.sh mysql etcd rabbitmq
> #       下载 OpenStack ：
>         ./deploy.sh openstack
> 
> #----------------------------------------------------------
> ```

## 已测试

- [ ] keystone           
- [ ] glance             
- [ ] nova_controller    
- [ ] nova_compute       
- [x] neutron_controller 
- [x] neutron_compute    
- [ ] ironic             
- [x] odl_controller     
- [x] odl_compute        
- [x] installationSource 
- [x] mysql              
- [x] rabbitmq           
- [x] openstack          
- [x] etcd               


## 加入
[gitlib](http://10.17.12.61/zyl/autoDeployOpenStack)

