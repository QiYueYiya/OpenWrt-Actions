# X86-School
此版本为校园网特供版

## UA2F配置(需手动配置)

```bash
# 开机自启
uci set ua2f.enabled.enabled=1
# 自动配置防火墙
uci set ua2f.firewall.handle_fw=1
# 处理 443 端口流量，443 端口出现 http 流量的概率较低
uci set ua2f.firewall.handle_tls=0
# 处理微信的mmtls
uci set ua2f.firewall.handle_mmtls=1
# 处理内网流量，防止在访问内网服务时被检测到
uci set ua2f.firewall.handle_intranet=1
# 应用uci修改
uci commit ua2f
# 启动ua2f开机自启
service ua2f enable
# 启动ua2f
service ua2f start
```

## 防火墙配置(已自动配置)

```bash
# 通过 iptables 修改 TTL 值
iptables -t mangle -A POSTROUTING -j TTL --ttl-set 128
# 防时钟偏移检测
iptables -t nat -N ntp_force_local
iptables -t nat -I PREROUTING -p udp --dport 123 -j ntp_force_local
iptables -t nat -A ntp_force_local -d 0.0.0.0/8 -j RETURN
iptables -t nat -A ntp_force_local -d 127.0.0.0/8 -j RETURN
iptables -t nat -A ntp_force_local -d 192.168.0.0/16 -j RETURN
iptables -t nat -A ntp_force_local -s 192.168.0.0/16 -j DNAT --to-destination 192.168.3.1
```

## 验证

1. 只需要关注“如果你的真实UA是(服务器获取的 UA)”，下面的“你的浏览器UA是”无需关注
2. 进行测试时请确保你没用使用任何VPN代理，因为VPN代理会加密流量进而导致UA2F不会去修改加密请求的UA
3. 访问：[UA检测-HTTP](http://ua.233996.xyz/)，如果你的真实UA是(服务器获取的 UA)：FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
4. 说明配置正确

## 注意
- UA2F可能会与科学上网插件冲突，因此要做好取舍。具体表现为80端口修改失效，其它部分端口正常
- UA2F也可能会和mwan3冲突，也不要开启Flow Offloading加速以及其他QoS工具
- 由于微信mmtls协议的影响，会可能会导致微信图片无法发送，如有需要请关闭处理微信的mmtls
- 建立NTP服务器统一时间戳防时钟偏移检测这种方案并不完善，设备在接入网络后可能更新时间不及时，所以建议手动触发更新时间
