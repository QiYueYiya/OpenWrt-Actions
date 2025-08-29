#!/bin/bash
#####################################################
# feeds_after.sh 在更新并安装软件源后执行
# feeds_after.sh 和 feeds_before.sh 至少存在其一
#####################################################
#
#
# openwrt-packages
git clone --depth 1 -b main https://github.com/QiYueYiya/openwrt-packages package/openwrt-packages
# Easytier
git clone --depth 1 -b main https://github.com/EasyTier/luci-app-easytier.git package/package-easytier
# Mosdns
rm -rf feeds/packages/lang/golang
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/v2ray-geodata
git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/package-mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
