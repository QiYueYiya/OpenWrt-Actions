# 修改默认IP地址
sed -i 's/192.168.1.1/172.16.1.1/g' package/base-files/files/bin/config_generate
sed -i 's/255.255.255.0/255.255.0.0/g' package/base-files/files/bin/config_generate
# 修改主机名
sed -i "s/hostname='OpenWrt'/hostname='Pardofelis'/g" package/base-files/files/bin/config_generate
# 修改设备说明
sed -i '/openwrt_release/d' package/lean/default-settings/files/zzz-default-settings
sed -i "s/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION='QiYueYi $(date +"%y%m%d")'/g" package/base-files/files/etc/openwrt_release