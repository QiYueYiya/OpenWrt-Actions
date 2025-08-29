#!/bin/bash
#####################################################
# 自定义设备相关设置
#####################################################
#
#
sed -i "s/192.168.1.1/"192.168.4.1"/g" package/base-files/files/bin/config_generate
sed -i "s/hostname='ImmortalWrt'/hostname='360T7'/g" package/base-files/files/bin/config_generate
sed -i "s/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION='QiYueYi $(date +"%y%m%d")'/g" package/base-files/files/etc/openwrt_release
