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

# 自定义软件源
git clone --depth 1 -b main https://github.com/QiYueYiya/openwrt-packages.git package/openwrt-packages
# Easytier
git clone --depth 1 -b main https://github.com/EasyTier/luci-app-easytier.git package/luci-app-easytier # 临时存放easytier
mv package/luci-app-easytier/easytier package/openwrt-packages/easytier # 移动easytier到openwrt-packages
mv package/luci-app-easytier/luci-app-easytier package/openwrt-packages/luci-app-easytier # 移动luci-app-easytier到openwrt-packages
rm -rf package/luci-app-easytier # 删除临时存放easytier