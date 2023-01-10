sed -i '/exit 0/d' package/lean/default-settings/files/zzz-default-settings
sed -i '/openwrt_release/d' package/lean/default-settings/files/zzz-default-settings
echo "echo 'iptables -t mangle -A POSTROUTING -j TTL --ttl-set 128' >> /etc/firewall.user" >> package/lean/default-settings/files/zzz-default-settings
echo "echo 'iptables -t nat -N ntp_force_local' >> /etc/firewall.user" >> package/lean/default-settings/files/zzz-default-settings
echo "echo 'iptables -t nat -I PREROUTING -p udp --dport 123 -j ntp_force_local' >> /etc/firewall.user" >> package/lean/default-settings/files/zzz-default-settings
echo "echo 'iptables -t nat -A ntp_force_local -d 0.0.0.0/8 -j RETURN' >> /etc/firewall.user" >> package/lean/default-settings/files/zzz-default-settings
echo "echo 'iptables -t nat -A ntp_force_local -d 127.0.0.0/8 -j RETURN' >> /etc/firewall.user" >> package/lean/default-settings/files/zzz-default-settings
echo "echo 'iptables -t nat -A ntp_force_local -d 192.168.0.0/16 -j RETURN' >> /etc/firewall.user" >> package/lean/default-settings/files/zzz-default-settings
echo "echo 'iptables -t nat -A ntp_force_local -s 192.168.0.0/16 -j DNAT --to-destination 192.168.3.1' >> /etc/firewall.user" >> package/lean/default-settings/files/zzz-default-settings
echo "exit 0" >> package/lean/default-settings/files/zzz-default-settings
sed -i 's/192.168.1.1/192.168.3.1/g' package/base-files/files/bin/config_generate
sed -i "s/hostname='OpenWrt'/hostname='DESKTOP'/g" package/base-files/files/bin/config_generate
sed -i "s/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION='OpenWrt By QiYueYi $(date +"%y%m%d")'/g" package/base-files/files/etc/openwrt_release
# 调整 V2ray服务器 到 VPN 菜单
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/controller/*.lua
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/model/cbi/v2ray_server/*.lua
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/view/v2ray_server/*.htm
target=$(grep -m 1 "CONFIG_TARGET_.*=y" .config | sed 's/CONFIG_TARGET_\(.*\)=y/\1/g')
for configFile in $(ls target/linux/$target/config*)
do
    echo -e "\nCONFIG_NETFILTER_NETLINK_GLUE_CT=y" >> $configFile
done
