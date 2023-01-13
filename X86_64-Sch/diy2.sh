sed -i 's/192.168.1.1/192.168.3.1/g' package/base-files/files/bin/config_generate
sed -i "s/hostname='OpenWrt'/hostname='DESKTOP'/g" package/base-files/files/bin/config_generate
sed -i '/openwrt_release/d' package/lean/default-settings/files/zzz-default-settings
sed -i "s/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION='Pardofelis and QiYueYi $(date +"%y%m%d")'/g" package/base-files/files/etc/openwrt_release
# 调整 V2ray服务器 到 VPN 菜单
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/controller/*.lua
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/model/cbi/v2ray_server/*.lua
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/view/v2ray_server/*.htm
target=$(grep -m 1 "CONFIG_TARGET_.*_.*" .config | sed "s/CONFIG_TARGET_\(.*\)_\(.*\)=y/\1\/\2/g")
for configFile in $(ls target/linux/$target/config*)
do
    echo -e "\nCONFIG_NETFILTER_NETLINK_GLUE_CT=y" >> $configFile
done
