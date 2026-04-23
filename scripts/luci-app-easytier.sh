mkdir -p packages/luci-app-easytier/root/etc/uci-defaults
cat > packages/luci-app-easytier/root/etc/uci-defaults/luci-i18n-easytier-zh-cn << 'EOF'
#!/bin/sh
uci -q batch << EOI
set luci.languages.zh_cn='简体中文 (Simplified Chinese)'
commit luci
EOI
rm -f /tmp/luci-indexcache /tmp/luci-modulecache/*
exit 0
EOF
chmod +x packages/luci-app-easytier/root/etc/uci-defaults/luci-i18n-easytier-zh-cn