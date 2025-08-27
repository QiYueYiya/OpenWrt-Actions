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
# 自定义软件源
git clone --depth 1 -b main https://github.com/QiYueYiya/openwrt-packages package/openwrt-packages
# Easytier
git clone --depth 1 -b main https://github.com/EasyTier/luci-app-easytier.git package/package-easytier
