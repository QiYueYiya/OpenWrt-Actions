# 主机名，可自定义
export hostname="OpenWrt"
# 设备型号，必须与官方设备型号一致
export profile="generic"
# 设备架构，必须与官方设备架构一致
export targets="x86/64"
# 设备CPU架构（用于下载预编译包）
export arch="x86_64"
# OpenWrt版本，必须与官方版本一致
export version="24.10.6"
# 后台管理IP地址
export ip_address="192.168.3.1"
# 网络掩码
export netmask="255.255.255.0"
if [ -f "imagebuilder/.config" ]; then
    sed -i 's/CONFIG_ISO_IMAGES=y/# CONFIG_ISO_IMAGES is not set/' imagebuilder/.config
    sed -i 's/CONFIG_QCOW2_IMAGES=y/# CONFIG_QCOW2_IMAGES is not set/' imagebuilder/.config
    sed -i 's/CONFIG_VDI_IMAGES=y/# CONFIG_VDI_IMAGES is not set/' imagebuilder/.config
    sed -i 's/CONFIG_VMDK_IMAGES=y/# CONFIG_VMDK_IMAGES is not set/' imagebuilder/.config
    sed -i 's/CONFIG_VHDX_IMAGES=y/# CONFIG_VHDX_IMAGES is not set/' imagebuilder/.config
    sed -i 's/CONFIG_TARGET_KERNEL_PARTSIZE=.*/CONFIG_TARGET_KERNEL_PARTSIZE=128/' imagebuilder/.config
    sed -i 's/CONFIG_TARGET_ROOTFS_PARTSIZE=.*/CONFIG_TARGET_ROOTFS_PARTSIZE=896/' imagebuilder/.config
    sed -i 's/CONFIG_TARGET_ROOTFS_AUTORESIZE=y/# CONFIG_TARGET_ROOTFS_AUTORESIZE is not set/' imagebuilder/.config
    # Download and place OpenClash core
    core_url="https://github.com/MetaCubeX/mihomo/releases/download/v1.19.25/mihomo-linux-amd64-v3-v1.19.25.gz"
    core_dir="imagebuilder/files/etc/openclash/core"
    tmp_gz="/tmp/mihomo-linux-amd64-v3-v1.19.25.gz"
    mkdir -p "$core_dir"
    curl -L -o "$tmp_gz" "$core_url"
    gzip -dc "$tmp_gz" > "$core_dir/clash_meta"
    chmod +x "$core_dir/clash_meta"
    rm -f "$tmp_gz"
fi
