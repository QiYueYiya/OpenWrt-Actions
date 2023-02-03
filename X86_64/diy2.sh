#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i '/openwrt_release/d' package/lean/default-settings/files/zzz-default-settings
sed -i 's/192.168.1.1/172.16.1.1/g' package/base-files/files/bin/config_generate
sed -i 's/255.255.255.0/255.255.0.0/g' package/base-files/files/bin/config_generate
sed -i "s/hostname='OpenWrt'/hostname='Pardofelis'/g" package/base-files/files/bin/config_generate
sed -i "s/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION='QiYueYi $(date +"%y%m%d")'/g" package/base-files/files/etc/openwrt_release
echo "DISTRIB_MODEL='X86_64'" >> package/base-files/files/etc/openwrt_release
target=$(grep -m 1 "CONFIG_TARGET_.*=y" .config | sed "s/CONFIG_TARGET_\(.*\)=y/\1/g")
sed -i 's/KERNEL_TESTING_PATCHVER:=.*/KERNEL_TESTING_PATCHVER:=5.15/g' target/linux/$target/Makefile
