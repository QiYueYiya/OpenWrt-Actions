#!/bin/sh
# 该脚本为immortalwrt首次启动时 运行的脚本 即 /etc/uci-defaults/99-custom.sh 也就是说该文件在路由器内 重启后消失 只运行一次
# 基础变量
ip_address="192.168.1.1"
netmask="255.255.255.0"
LOGFILE="/etc/config/uci-defaults-log.txt"

# 设置路由器管理后台地址
uci set network.lan.ipaddr=$ip_address
# 设置子网掩码
uci set network.lan.netmask=$netmask
# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''
uci commit

# 设置编译作者信息
FILE_PATH="/etc/openwrt_release"
NEW_DESCRIPTION="By QiYueYiya"
sed -i "s/DISTRIB_DESCRIPTION='[^']*'/DISTRIB_DESCRIPTION='$NEW_DESCRIPTION'/" "$FILE_PATH"

exit 0
