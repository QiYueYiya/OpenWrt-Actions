# 主机名，可自定义
export hostname="OpenWrt"
# 设备名称，必须与官方设备名称一致
export profile="generic"
# 设备架构，必须与官方设备架构一致
export targets="x86/64"
# 设备CPU架构（用于下载预编译包）
export arch="x86_64"
# OpenWrt版本，必须与官方版本一致
export version="24.10.5"
# 后台管理IP地址
export ip_address="172.16.0.2"
# 网络掩码
export netmask="255.255.255.0"
if [ -f ".config" ]; then
    sed -i 's/CONFIG_ISO_IMAGES=y/# CONFIG_ISO_IMAGES is not set/' .config
    sed -i 's/CONFIG_QCOW2_IMAGES=y/# CONFIG_QCOW2_IMAGES is not set/' .config
    sed -i 's/CONFIG_VDI_IMAGES=y/# CONFIG_VDI_IMAGES is not set/' .config
    sed -i 's/CONFIG_VMDK_IMAGES=y/# CONFIG_VMDK_IMAGES is not set/' .config
    sed -i 's/CONFIG_VHDX_IMAGES=y/# CONFIG_VHDX_IMAGES is not set/' .config
fi
