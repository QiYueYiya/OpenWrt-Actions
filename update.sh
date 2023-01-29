#!/bin/bash
model_name=`cat /etc/openwrt_release | grep "MODEL" | sed "s/.*MODEL='\(.*\)'/\1/g"`
if [ "$model_name" == "360T7" ] ;then
    model_file="360T7-108M-sysupgrade.bin"
elif [ "$model_name" == "360T7-AP" ] ;then
    model_file="360T7-AP-108M-sysupgrade.bin"
elif [ "$model_name" == "X86_64" ] ;then
    [ -d /sys/firmware/efi ] && model_file="X86_64-squashfs-efi.img.gz" || model_file="X86_64-squashfs.img.gz"
elif [ "$model_name" == "X86_64-Sch" ] ;then
    model_name="X86_64"
    [ -d /sys/firmware/efi ] && model_file="X86_64-squashfs-efi.img.gz" || model_file="X86_64-squashfs.img.gz"
fi
version=`cat /etc/openwrt_release | grep "DESCRIPTION" | sed "s/.*DESCRIPTION='.*\s\(\d*\)'/\1/g"`
latest_version=`curl -sSL "https://api.github.com/repos/QiYueYiya/OpenWrt-Actions/releases/tags/$model_name" | grep "name.*$model_name-\d\d\d\d" | sed "s/.*$model_name-\(\d\d\d\d\d\d\).*/\1/g"`
echo "设备型号：$model_name"
echo "当前版本：$version"
echo "云端版本：$latest_version"
if [ $latest_version -gt $version ] ;then
    echo "检测到新版本！开始下载固件"
    url="https://gh-proxy.com/https://github.com/QiYueYiya/OpenWrt-Actions/releases/download"
    dir=$(cd $(dirname $0);pwd)
    wget -O $dir/$model_file "$url/$model_name/$model_file"
    wget -O $dir/file.sha256 "$url/$model_name/sha256sums"
    echo "开始校验文件哈希值"
    if cat file.sha256 | grep $model_file | sha256sum -cs ;then
        echo "哈希值校验通过，开始升级"
        sysupgrade -c $dir/$model_file
    else
        echo "哈希值校验不通过！退出升级"
    fi
else
    echo "已是最新版本！"
fi
