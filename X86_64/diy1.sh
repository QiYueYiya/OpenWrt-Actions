#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
# sed -i '$a src-git small8 https://github.com/kenzok8/small-package' feeds.conf.default

# 软件包
git clone --depth 1 https://github.com/pymumu/openwrt-smartdns.git package/smartdns
git clone --depth 1 -b lede https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns
wget -O openwrt-passwall-8728dabfb69da30fd52dd71c47fb4ce3ee49cbff.zip https://github.com/xiaorouji/openwrt-passwall/archive/8728dabfb69da30fd52dd71c47fb4ce3ee49cbff.zip
wget -O openwrt-passwall-d6fc247a56b12dc521329100535b6e6154bb05a0.zip https://github.com/xiaorouji/openwrt-passwall/archive/d6fc247a56b12dc521329100535b6e6154bb05a0.zip
mkdir package/passwall
for configFile in $(find *.zip|sed "s/.zip//g")
do
    unzip -q $configFile
    mv $configFile/* package/passwall/
    rm -rf $configFile*
done

# 主题
git clone --depth 1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
rm -rf package/luci-theme-argon/README* package/luci-theme-argon/Screenshots/
sed -i 's/luci-theme-argon-18.06/luci-theme-argon/g' package/luci-theme-argon/Makefile
