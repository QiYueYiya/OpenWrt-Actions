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
git clone --depth 1 https://github.com/tty228/luci-app-wechatpush.git package/luci-app-wechatpush
git clone --depth 1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
# Easytier
git clone --depth 1 -b main https://github.com/EasyTier/luci-app-easytier.git luci-app-easytier
mv luci-app-easytier/easytier package/easytier
mv luci-app-easytier/luci-app-easytier package/luci-app-easytier
rm -rf luci-app-easytier
