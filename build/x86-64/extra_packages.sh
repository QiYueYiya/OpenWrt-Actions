#!/bin/bash
# 仅放置自定义插件（第三方/手工维护）
# 默认注释状态，按需开启

# =========================== 自定义第三方 插件 ===========================

# AdGuard Home - 广告过滤工具
# PACKAGES="$PACKAGES luci-app-adguardhome"

# MosDNS - DNS解析工具
# PACKAGES="$PACKAGES luci-app-mosdns"
# PACKAGES="$PACKAGES luci-i18n-mosdns-zh-cn"

# Easytier - P2P组网工具
PACKAGES="$PACKAGES easytier"
PACKAGES="$PACKAGES luci-app-easytier"
PACKAGES="$PACKAGES luci-i18n-easytier-zh-cn"
