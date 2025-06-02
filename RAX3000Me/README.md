# 准备事项
RAX3000Me带USB款，DDR3闪存，生产日期20241129

理论上DDR4闪存也能用，没有设备无法测试，Preloader和Uboot文件也与教程内不同，但会放在下载地址内，自行判断能否使用，概不负责

推荐使用OpenWrt、Ubuntu、WSL等```Linux系统```，如果是```Windows系统```，需要下载安装openssl程序

使用到的文件下载地址: [刷机准备文件](https://github.com/QiYueYiya/OpenWrt-Actions/releases/tag/RAX3000Me_Files)、[RAX3000Me固件](https://github.com/QiYueYiya/OpenWrt-Actions/releases/tag/RAX3000Me)
- Kernel：mt7981-cmcc_rax3000me-initramfs-recovery.itb
- Preloader：mt7981-cmcc_rax3000me-nand-ddr3-preloader.bin
- Uboot：mt7981-cmcc_rax3000me-nand-ddr3-fip-fit.bin
- Sysupgrade：RAX3000Me-yyMMdd-squashfs-sysupgrade.itb

感谢[tomatojack](https://www.right.com.cn/forum/space-uid-938072.html)、[lgs2007m](https://github.com/lgs2007m)、[immortalwrt](https://github.com/immortalwrt)等大佬

# 开始教程
## 一、开启Telnet
### 1. 在任意Linux终端输入路由器```SN码```
在路由器背面，我的是一串长度为25的数字，不要照抄，按照自己的输入，注意大小写
```shell
SN=1234567890ABCDEFGHIJKLMNO
```
### 2. 生成密码
```shell
mypassword=$(openssl passwd -1 -salt aV6dW8bD "$SN")
mypassword=$(eval "echo $mypassword")
echo $mypassword
```
### 3. 下载开启```Telnet```配置文件
```shell
wget https://github.com/QiYueYiya/OpenWrt-Actions/releases/download/RAX3000Me_Files/RAX3000M_XR30_cfg-telnet-20240117.conf
```
- <details>
    <summary>国内网络下载命令</summary>

    ```shell
    wget https://github.akams.cn/https://github.com/QiYueYiya/OpenWrt-Actions/releases/download/RAX3000Me_Files/RAX3000M_XR30_cfg-telnet-20240117.conf
    ```
    </details>

### 4. 加密配置文件，然后上传导入到路由器，等待重启后即可解锁```Telnet```
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

## 二、刷入preloader和Uboot
使用任意```Telnet工具```登录到路由器，默认无密码
### 1. 下载```preloader```和```Uboot```到路由器```/tmp```目录下
```shell
wget -P /tmp https://github.com/QiYueYiya/OpenWrt-Actions/releases/download/RAX3000Me_Files/mt7981-cmcc_rax3000me-nand-ddr3-preloader.bin
```
```shell
wget -P /tmp https://github.com/QiYueYiya/OpenWrt-Actions/releases/download/RAX3000Me_Files/mt7981-cmcc_rax3000me-nand-ddr3-fip-fit.bin
```
- <details>
    <summary>国内网络下载命令</summary>

    ```shell
    wget -P /tmp https://github.akams.cn/https://github.com/QiYueYiya/OpenWrt-Actions/releases/download/RAX3000Me_Files/mt7981-cmcc_rax3000me-nand-ddr3-preloader.bin
    ```

    ```shell
    wget -P /tmp https://github.akams.cn/https://github.com/QiYueYiya/OpenWrt-Actions/releases/download/RAX3000Me_Files/mt7981-cmcc_rax3000me-nand-ddr3-fip-fit.bin
    ```
    </details>
- <details>
    <summary>路由器无网下载方法</summary>
    
    #### 先在电脑上下载好[preloader](https://github.com/QiYueYiya/OpenWrt-Actions/releases/download/RAX3000Me_Files/mt7981-cmcc_rax3000me-nand-ddr3-preloader.bin)、[Uboot](https://github.com/QiYueYiya/OpenWrt-Actions/releases/download/RAX3000Me_Files/mt7981-cmcc_rax3000me-nand-ddr3-fip-fit.bin)
    #### 设置电脑网卡为固定IP ```192.168.10.2/24```（该IP需要和路由器在同一个网段，注意只使用一个网卡，无线也不要连接）
    #### 然后打开```HTTP File Server```软件，将对应```preloader```和```Uboot```文件拖拽到软件，然后使用下面对应的命令下载到```/tmp```目录：
    ```
    wget -P /tmp http://192.168.10.2/mt7981-cmcc_rax3000me-nand-ddr3-preloader.bin
    ```
    ```
    wget -P /tmp http://192.168.10.2/mt7981-cmcc_rax3000me-nand-ddr3-fip-fit.bin
    ```
    </details>

### 2. 烧写```preloader```
```
mtd write /tmp/mt7981-cmcc_rax3000me-nand-ddr3-preloader.bin BL2
```
### 3. 验证```preloader```写入情况
```
mtd write /tmp/mt7981-cmcc_rax3000me-nand-ddr3-preloader.bin BL2
```
- 执行后显示Success即为成功
### 4. 烧写```Uboot```
```
mtd write /tmp/mt7981-cmcc_rax3000me-nand-ddr3-fip-fit.bin FIP
```
### 5. 验证```Uboot```写入情况
```
mtd write /tmp/mt7981-cmcc_rax3000me-nand-ddr3-fip-fit.bin FIP
```
### 4. 重启进入Uboot
```
reboot
```
- <details>
    <summary>如果重启后没有自动进入Uboot看这里</summary>
    
    #### 断开电源后，用牙签顶住```RESET```按钮，插上电源后大约```5-10```秒，指示灯变```绿色```后松开按钮，网线一头插电脑上，另一头插在路由器LAN口上
    </details>

## 三、开始刷机
#### 1. 浏览器输入```192.168.1.1```进入Uboot，选择 [RAX3000Me-initramfs-recovery.itb](https://github.com/QiYueYiya/OpenWrt-Actions/releases/download/RAX3000Me_Files/mt7981-cmcc_rax3000me-initramfs-recovery.itb) 文件刷写等待重启

#### 2. 路由器重启完毕，电脑获取IP后，浏览器输入```192.168.1.1```，在```系统-->备份与升级-->刷写固件```里刷写 [RAX3000Me-yyMMdd-squashfs-sysupgrade.itb](https://github.com/QiYueYiya/OpenWrt-Actions/releases/tag/RAX3000Me) 固件，新固件后台地址为```192.168.5.1```
