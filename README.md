## 说明
主分支已迁移到23.05，初始分支仅作保留

## 目录结构规范
   ```
   build/
   └── [target]/               # 如 mediatek/filogic
       ├── diy_package.sh      # 必选文件
       ├── feeds.conf.default  # 可选文件
       └── [model]/            # 如 360T7、RAX3000Me
           ├── files/          # 参考 OpenWrt 官方文档
           ├── .config         # 设备配置文件
           └── diy_device.sh   # 设备专属脚本
   ```

## 固件列表
| 设备名称 | 配置目录 | 固件下载 |
| :-------------: | :-------------: | :-------------: |
| [![](https://img.shields.io/badge/immortalwrt-360T7-32C955.svg?logo=openwrt)](https://github.com/QiYueYiya/OpenWrt-Actions/blob/23.05/.github/workflows/Build-OpenWrt.yml) | [![](https://img.shields.io/badge/编译-配置-orange.svg?logo=apache-spark)](https://github.com/QiYueYiya/OpenWrt-Actions/tree/23.05/build/mediatek/filogic/360T7) | [![](https://img.shields.io/badge/下载-链接-blueviolet.svg?logo=hack-the-box)](https://github.com/QiYueYiya/OpenWrt-Actions/releases/tag/360T7) |
| [![](https://img.shields.io/badge/immortalwrt-RAX3000Me-32C955.svg?logo=openwrt)](https://github.com/QiYueYiya/OpenWrt-Actions/blob/23.05/.github/workflows/Build-OpenWrt.yml) | [![](https://img.shields.io/badge/编译-配置-orange.svg?logo=apache-spark)](https://github.com/QiYueYiya/OpenWrt-Actions/tree/23.05/build/mediatek/filogic/RAX3000Me) | [![](https://img.shields.io/badge/下载-链接-blueviolet.svg?logo=hack-the-box)](https://github.com/QiYueYiya/OpenWrt-Actions/releases/tag/RAX3000Me) |

## 赞助

![star](.github/files/star.png)

## 鸣谢
- [P3TERX](https://github.com/P3TERX)
- [hanwckf](https://github.com/hanwckf)
- [padavanonly](https://github.com/padavanonly)
- [immortalwrt](https://github.com/immortalwrt)