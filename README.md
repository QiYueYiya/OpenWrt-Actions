## 注意
- 固件更新时间为每周五凌晨两点
- 本仓库为我个人自用，部分固件配置不适用于你，请小心使用

## 固件列表
| 设备名称 | 编译状态 | 配置文件 | 源地址 | 固件下载 |
| :-------------: | :-------------: | :-------------: | :-------------: | :-------------: |
| [360T7](https://github.com/QiYueYiya/OpenWrt-Actions/tree/main/360T7) | [![](https://github.com/QiYueYiya/OpenWrt-Actions/actions/workflows/360T7.yml/badge.svg)](https://github.com/QiYueYiya/OpenWrt-Actions/actions/workflows/360T7.yml) | [Config](https://github.com/QiYueYiya/OpenWrt-Actions/blob/main/360T7/.config) | [软件源](https://github.com/QiYueYiya/OpenWrt-Actions/blob/main/360T7/files/etc/opkg/distfeeds.conf) | [下载链接](https://github.com/QiYueYiya/OpenWrt-Actions/releases/tag/360T7) |
| [360T7-AP](https://github.com/QiYueYiya/OpenWrt-Actions/tree/main/360T7-AP) | [![](https://github.com/QiYueYiya/OpenWrt-Actions/actions/workflows/360T7-AP.yml/badge.svg)](https://github.com/QiYueYiya/OpenWrt-Actions/actions/workflows/360T7-AP.yml) | [Config](https://github.com/QiYueYiya/OpenWrt-Actions/blob/main/360T7/.config) | [软件源](https://github.com/QiYueYiya/OpenWrt-Actions/blob/main/360T7-AP/files/etc/opkg/distfeeds.conf) | [下载链接](https://github.com/QiYueYiya/OpenWrt-Actions/releases/tag/360T7-AP) |
| [X86_64](https://github.com/QiYueYiya/OpenWrt-Actions/tree/main/X86_64) | [![](https://github.com/QiYueYiya/OpenWrt-Actions/actions/workflows/X86_64.yml/badge.svg)](https://github.com/QiYueYiya/OpenWrt-Actions/actions/workflows/X86_64.yml) | [Config](https://github.com/QiYueYiya/OpenWrt-Actions/blob/main/X86_64/.config) | [软件源](https://github.com/QiYueYiya/OpenWrt-Actions/blob/main/X86_64/files/etc/opkg/distfeeds.conf) | [下载链接](https://github.com/QiYueYiya/OpenWrt-Actions/releases/tag/X86_64) |
| [X86_64-Sch](https://github.com/QiYueYiya/OpenWrt-Actions/tree/main/X86_64-Sch) | [![](https://github.com/QiYueYiya/OpenWrt-Actions/actions/workflows/X86_64-Sch.yml/badge.svg)](https://github.com/QiYueYiya/OpenWrt-Actions/actions/workflows/X86_64-Sch.yml) | [Config](https://github.com/QiYueYiya/OpenWrt-Actions/blob/main/X86_64-Sch/.config) | [软件源](https://github.com/QiYueYiya/OpenWrt-Actions/blob/main/X86_64-Sch/files/etc/opkg/distfeeds.conf) | [下载链接](https://github.com/QiYueYiya/OpenWrt-Actions/releases/tag/X86_64-Sch) |

## 一键升级固件
```bash
bash <(curl -sSL https://raw.gh.fakev.cn/QiYueYiya/OpenWrt-Actions/main/update.sh)
```

## 一键配置UA2F
```bash
bash <(curl -sSL https://raw.gh.fakev.cn/QiYueYiya/OpenWrt-Actions/main/ua2f.sh)
```

## 验证
- 进行测试时请确保你没用使用任何VPN代理，因为VPN代理会加密流量进而导致UA2F不会去修改加密请求的UA
- 只需要关注“如果你的真实UA是(服务器获取的 UA)”，下面的“你的浏览器UA是”无需关注
- 访问：[UA检测-HTTP](http://ua.233996.xyz/)，如果你的真实UA是(服务器获取的 UA)：
```bash
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
```
- 说明配置正确

## 注意
- UA2F可能会与科学上网、负载均衡mwan3、Flow Offloading加速、硬件NAT加速、QOS限速等插件发生冲突
- 由于微信mmtls协议的影响，可能会导致微信图片无法发送，如有需要请关闭处理微信的mmtls
- 建立NTP服务器统一时间戳防时钟偏移检测这种方案并不完善，设备在接入网络后可能更新时间不及时，所以建议手动触发更新时间

## 参考
- [P3TERX](https://github.com/P3TERX/Actions-OpenWrt)
- [hanwckf](https://github.com/hanwckf/immortalwrt-mt798x)
- [padavanonly](https://github.com/padavanonly/immortalwrtARM)
- [immortalwrt](https://github.com/immortalwrt/immortalwrt)
- [coolsnowwolf](https://github.com/coolsnowwolf/lede)
- [UA2F](https://github.com/Zxilly/UA2F)
- [UA2F详细教程](https://sunbk201public.notion.site/sunbk201public/OpenWrt-f59ae1a76741486092c27bc24dbadc59)