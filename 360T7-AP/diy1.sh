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

# Add feed sources
sed -i '$a src-git-full small https://github.com/kenzok8/small-package' feeds.conf.default
# theme
# git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
# rm -rf package/luci-theme-argon/README* package/luci-theme-argon/Screenshots/
