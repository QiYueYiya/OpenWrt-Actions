#!/bin/bash
./scripts/feeds update -a && ./scripts/feeds install -a
# Adguardhome
git clone --depth 1 -b main https://github.com/QiYueYiya/openwrt-packages package/openwrt-packages
# Easytier
git clone --depth 1 -b main https://github.com/EasyTier/luci-app-easytier.git package/package_easytier
# Mosdns
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/v2ray-geodata
rm -rf feeds/packages/lang/golang
git clone --depth 1 -b 24.x https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
git clone --depth 1 -b v5 https://github.com/sbwml/luci-app-mosdns package/package_mosdns
git clone --depth 1 -b master https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# 要编译的IPK
cat > packages_compile << EOF
luci-app-adguardhome
easytier
luci-app-easytier
luci-app-mosdns
EOF

# 要复制出来的IPK
cat > packages_list << EOF
luci
easytier
v2ray-geoip
v2ray-geosite
v2dat
mosdns
EOF