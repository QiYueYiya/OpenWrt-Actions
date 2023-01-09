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
# 处理微信的 mmtls
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

访问：[UA检测-HTTP](http://ua.233996.xyz/)

## 注意

<aside>
⚠️ **为什么我使用了 UA2F + TTL 伪装 方案依旧被检测到？**
UA2F可能会与SSRP+等科学上网工具冲突，因此要做好取舍。具体表现为80端口修改失效，其它部分端口正常
</aside>
<aside>
⚠️ UA2F也可能会和mwan3冲突，也不要开启 Flow Offloading 加速以及其他 QoS 工具
</aside>
<aside>
⚠️ 由于微信mmtls协议的影响，会可能会导致微信图片无法发送等问题，此问题可执行 `uci set ua2f.firewall.handle_mmtls=0 && uci commit ua2f` 解决
</aside>
<aside>
⚠️ **为什么我使用了UA2F+TTL伪装方案依旧被检测到？**
有一种可能是Windows操作系统自身会与微软服务器维持24小时不间断的长连接，Android亦会如此，网关可以通过监视不同操作系统厂商的不同长连接进行判断检测。这种情况建议使用Clash+TTL伪装方案
</aside>
<aside>
⚠️ 关于建立 NTP 服务器统一时间戳防时钟偏移检测，这种方案并不完善，设备在接入网络后可能更新时间不及时，所以建议手动触发更新时间
</aside>
