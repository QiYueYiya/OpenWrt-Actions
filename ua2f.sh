#!/bin/bash
################ 360T7专属设置 ################
hnat_path="/sys/kernel/debug/hnat/hook_toggle"
[ -e $hnat_path ] && echo "关闭硬件加速中"
[ -e $hnat_path ] && echo 0 > $hnat_path
[ -e $hnat_path ] && (grep hook_toggle /etc/rc.local && echo '硬件加速已关闭！' || sed -i "/exit*/iecho 0 > \/sys\/kernel\/debug\/hnat\/hook_toggle" /etc/rc.local)
##############################################
echo "配置ua2f中"
uci set ua2f.enabled.enabled=1
uci set ua2f.firewall.handle_fw=1
uci set ua2f.firewall.handle_tls=0
uci set ua2f.firewall.handle_mmtls=1
uci set ua2f.firewall.handle_intranet=1
uci commit ua2f
echo "启动ua2f"
/etc/init.d/ua2f enable
/etc/init.d/ua2f start
echo "开启NTP服务器"
uci set system.ntp.enable_server=1
uci commit system
/etc/init.d/system restart
echo "设置防火墙规则中"
echo -e "\n# 修改TTL值为128" >> /etc/firewall.user
echo "iptables -t mangle -A POSTROUTING -j TTL --ttl-set 128" >> /etc/firewall.user
echo -e "\n# 设置NTP服务器" >> /etc/firewall.user
echo "iptables -t nat -N ntp_force_local" >> /etc/firewall.user
echo "iptables -t nat -I PREROUTING -p udp --dport 123 -j ntp_force_local" >> /etc/firewall.user
echo "iptables -t nat -A ntp_force_local -d 0.0.0.0/8 -j RETURN" >> /etc/firewall.user
echo "iptables -t nat -A ntp_force_local -d 127.0.0.0/8 -j RETURN" >> /etc/firewall.user
echo "iptables -t nat -A ntp_force_local -d 192.168.0.0/16 -j RETURN" >> /etc/firewall.user
echo "iptables -t nat -A ntp_force_local -s 192.168.0.0/16 -j DNAT --to-destination 192.168.3.1" >> /etc/firewall.user
echo -e "\n# 来自tcp53端口流量转发至tcp3053端口" >> /etc/firewall.user
echo "iptables -t nat -A PREROUTING -p tcp --dport 53 -j REDIRECT --to-ports 3053" >> /etc/firewall.user
echo -e "\n# 来自br-lan udp53端口流量转发至udp3053端口" >> /etc/firewall.user
echo "iptables -t nat -A PREROUTING -i br-lan -p udp --dport 53 -j REDIRECT --to-ports 3053" >> /etc/firewall.user
echo -e "\n# 来自tun0 53端口流量转发至3053端口" >> /etc/firewall.user
echo "iptables -t nat -A PREROUTING -i tun0 -p udp --dport 53 -j REDIRECT --to-ports 3053" >> /etc/firewall.user
echo -e "\n# 来自eth1 udp53端口流量转发至udp1194端口" >> /etc/firewall.user
echo "iptables -t nat -A PREROUTING -i eth1 -p udp --dport 53 -j REDIRECT --to-ports 1194" >> /etc/firewall.user
echo "重启防火墙"
/etc/init.d/firewall restart