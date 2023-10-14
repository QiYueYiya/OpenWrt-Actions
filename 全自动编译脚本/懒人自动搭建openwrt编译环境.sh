#!/bin/bash

echo "为了保证编译环境顺利搭建，编译过程顺利进行，请保证您当前网络已经正确配置【科学上网】！！！按回车键进入下一步。。。"
read

echo "有一些步骤需要输入管理员密码，请留意观察。按回车键进入下一步。。。"
read

echo "即将开始，按回车键进入下一步。。。"
read

#更新系统软件包
sudo apt-get -y update && sudo apt-get -y upgrade
# 安装依赖软件包
sudo apt update
sudo apt install -y ack antlr3 aria2 asciidoc autoconf automake autopoint binutils bison build-essential \
bzip2 ccache cmake cpio curl device-tree-compiler fastjar flex gawk gettext gcc-multilib g++-multilib \
git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libglib2.0-dev libgmp3-dev libltdl-dev \
libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libreadline-dev libssl-dev libtool lrzsz \
mkisofs msmtp nano ninja-build p7zip p7zip-full patch pkgconf python2.7 python3 python3-pip libpython3-dev qemu-utils \
rsync scons squashfs-tools subversion swig texinfo uglifyjs upx-ucl unzip vim wget xmlto xxd zlib1g-dev

# 选择源码类型
echo "请选择源码类型："
echo "1. 官方源码"
echo "2. LEDE源码"
echo "3. 天灵源码"
read -p "请输入要使用的源码类型（1/2/3）：" choice

# 下载对应的源码
case $choice in
  1)
    git clone https://github.com/openwrt/openwrt.git && cd openwrt
    ;;
  2)
    git clone https://github.com/coolsnowwolf/lede && cd lede 
    ;;
  3)
    git clone https://github.com/immortalwrt/immortalwrt.git && cd immortalwrt
    ;;
  *)
    echo "无效的选择！"
    exit 1
    ;;
esac

#下载更新软件包源代码
./scripts/feeds update -a && ./scripts/feeds install -a

echo "按回车键进入下一步-配置构建文件"
read

make menuconfig

echo "按回车键进入下一步-下载dl库文件"
read

make download -j$(nproc) V=s

read -p "针对内核配置，输入y并回车表示同意，输入n表示跳过：" choice
if [ "$choice" == "n" ]; then
    echo "跳过内核配置"
elif [ "$choice" == "y" ]; then
    make kernel_menuconfig -j$(nproc) V=sc
else
    echo "无效的输入"
fi

echo "按回车键进入下一步-开始编译？"
read

make -j$(nproc) V=s

echo "编译过程已结束，请进入/bin/targets/ramips/查看是否正确生成固件文件"

read -n 1 -s -r -p "你完成了第一次编译，祝你好运；按下任意键结束脚本..."



