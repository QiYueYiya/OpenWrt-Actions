RAX3000Me带USB款，闪存型号fm25s01a，生产日期20241129，其他型号暂未测试

感谢[tomatojack](https://www.right.com.cn/forum/space-uid-938072.html)、[lgs2007m](https://github.com/lgs2007m)、[hanwckf](https://github.com/hanwckf)等大佬

使用到的文件下载地址: [RAX3000Me固件](https://github.com/QiYueYiya/OpenWrt-Actions/releases/tag/RAX3000Me)、[配置文件及Uboot](https://github.com/QiYueYiya/OpenWrt-Actions/releases/tag/RAX3000Me_Files)
## 一、开启Telnet
请使用OpenWrt、Ubuntu、WSL等```Linux系统```
#### 1. 在终端输入路由器```SN码```
在路由器背面，我的是一串长度为25的数字，不要照抄，按照自己的输入
```shell
SN=1234567890123456789012345
```
#### 2. 生成密码
```shell
mypassword=$(openssl passwd -1 -salt aV6dW8bD "$SN")
mypassword=$(eval "echo $mypassword")
echo $mypassword
```
#### 3. 下载开启```Telnet```配置文件
```shell
wget https://github.com/QiYueYiya/OpenWrt-Actions/releases/download/RAX3000Me_Files/RAX3000M_XR30_cfg-telnet-20240117.conf
```
- <details>
    <summary>国内网络下载命令</summary>

    ```shell
    wget https://github.akams.cn/https://github.com/QiYueYiya/OpenWrt-Actions/releases/download/RAX3000Me_Files/RAX3000M_XR30_cfg-telnet-20240117.conf
    ```
    </details>

#### 4. 加密配置文件，然后上传导入到路由器，等待重启后即可解锁```Telnet```
```shell
openssl aes-256-cbc -pbkdf2 -k "$mypassword" -in RAX3000M_XR30_cfg-telnet-20240117.conf -out cfg_import_config_file_new.conf
```
- <details>
    <summary>如果想自己修改配置文件看这里</summary>

    #### 用下面命令解密配置文件，需要先生成密码
    ```shell
    openssl aes-256-cbc -d -pbkdf2 -k "$mypassword" -in cfg_export_config_file.conf -out cfg_import_config_file_decrypt.conf
    ```
    #### 要加密配置文件后再上传
    ```shell
    tar -zcvf - etc | openssl aes-256-cbc -pbkdf2 -k "$mypassword" -out cfg_export_config_file_new.conf
    ```
    </details>

## 二、刷入Uboot
使用任意```Telnet工具```登录到路由器，默认无密码
#### 1. 下载```Uboot```到路由器```/tmp```目录下
```shell
wget -P /tmp https://github.com/QiYueYiya/OpenWrt-Actions/releases/download/RAX3000Me_Files/mt7981_cmcc_rax3000m-fip-fixed-parts.bin
```
- <details>
    <summary>国内网络下载命令</summary>

    ```shell
    wget -P /tmp https://github.akams.cn/https://github.com/QiYueYiya/OpenWrt-Actions/releases/download/RAX3000Me_Files/mt7981_cmcc_rax3000m-fip-fixed-parts.bin
    ```
    </details>
- <details>
    <summary>路由器无网下载方法</summary>
    
    #### 先在电脑上下载好[Uboot](https://github.com/hanwckf/bl-mt798x/releases)，解压提取出```mt7981_cmcc_rax3000m-fip-fixed-parts.bin```文件
    #### 设置电脑网卡为固定IP ```192.168.10.2/24```（注意只使用一个网卡，无线也不要连接）
    #### 然后打开```HTTP File Server```软件，将对应```Uboot```文件拖拽到软件，然后使用下面对应的命令下载到```/tmp```目录：
    ```
    wget -P /tmp http://192.168.10.2/mt7981_cmcc_rax3000m-fip-fixed-parts.bin
    ```
    </details>

#### 2. 烧写```Uboot```
```
mtd write /tmp/mt7981_cmcc_rax3000m-fip-fixed-parts.bin FIP
```
## 三、开始刷机
#### 1. 电脑的IP地址设置为```192.168.1.2```，子网掩码为```255.255.255.0```，网关为```192.168.1.1```
#### 2. 用牙签顶住```RESET```按钮，插上电源后大约```5-10```秒，指示灯变```绿色```后松开按钮，网线一头插电脑上，另一头插在路由器LAN口上
#### 3. 浏览器输入```192.168.1.1```，选择```factory固件```刷写等待重启
#### 4. 电脑改为自动获取IP地址，浏览器输入```192.168.5.1```，在固件里用软件升级刷写```sysupgrade固件```
