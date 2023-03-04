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
git clone --depth 1 https://github.com/Zxilly/UA2F package/UA2F
git clone --depth 1 https://github.com/pymumu/openwrt-smartdns.git package/smartdns
git clone --depth 1 -b lede https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns
git clone --depth 1 -b packages https://github.com/xiaorouji/openwrt-passwall.git package/passwall
git clone --depth 1 -b luci https://github.com/xiaorouji/openwrt-passwall.git package/luci-app-passwall
svn co https://github.com/Hyy2001X/AutoBuild-Packages/trunk/luci-app-adguardhome package/luci-app-adguardhome

# 主题
git clone --depth 1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
rm -rf package/luci-theme-argon/README* package/luci-theme-argon/Screenshots/
sed -i 's/luci-theme-argon-18.06/luci-theme-argon/g' package/luci-theme-argon/Makefile
