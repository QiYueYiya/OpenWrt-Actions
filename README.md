# OpenWrt-ImageBuilder

一个基于 GitHub Actions 的 ImmortalWrt ImageBuilder 自动化构建仓库。

本项目通过“设备目录 + 脚本约定”的方式管理不同机型配置，支持：
- 手动选择单个设备构建
- 一键构建全部已配置设备
- 叠加全局/设备级软件包
- 注入首次启动初始化脚本
- 自动发布固件到 GitHub Release

## 适用场景

- 想用 ImageBuilder 快速生成可刷写固件
- 想将多个设备配置标准化、版本化管理
- 想通过 GitHub Actions 云端自动构建并发布

## 仓库目录结构

```text
OpenWrt-ImageBuilder/
├─ .github/
│  └─ workflows/
│     └─ build-openwrt-image.yml      # CI 工作流：矩阵生成、下载、构建、发布
├─ build/
│  └─ cmcc_rax3000me/                 # 设备目录（一个目录代表一个 profile）
│     ├─ config.sh                    # 设备核心参数
│     ├─ packages.sh                  # immortalwrt 官方源插件
│     ├─ packages_custom.sh           # 自定义插件（第三方/手工维护）
│     └─ 99-custom.sh                 # 首次启动自定义脚本模板
└─ config/
   └─ default_packages.sh             # 全局默认软件包
```

## 设备目录（设备树）设计说明

本仓库的“设备树”是指 `build/<profile>/` 这一层级化组织方式，不是 DTS 源码树。

约定如下：
- `build/` 下每个子目录对应一个可构建设备
- 子目录名通常与设备 profile 一致（例如 `cmcc_rax3000me`）
- 该目录必须包含 `config.sh` 才会被 `all` 模式自动发现

### 1) config.sh（设备基础信息）

用于定义该设备构建所需的关键变量：
- `profile`：设备 profile 名称，传给 `make image PROFILE=...`，必须与官方 profile 一致
- `targets`：目标架构路径，如 `mediatek/filogic`
- `arch`：CPU 架构（如 `aarch64_cortex-a53`，用于包下载和发布）
- `version`：ImmortalWrt 版本，如 `24.10.5`
- `ip_address`、`netmask`：用于注入首次启动网络配置

### 2) packages.sh / extra_packages.sh（设备级软件包）

用于在全局包基础上追加设备专属包，分为两类：
- `packages.sh`：immortalwrt 官方源可直接安装的包
- `extra_packages.sh`：自定义插件（第三方或手工维护，支持自动下载预编译包）

常见包类型：
- 内核模块（`kmod-*`）
- 设备相关功能插件

脚本通过追加 `PACKAGES` 变量参与最终构建参数。

### 3) 99-custom.sh（首次启动脚本）

该脚本会被复制到固件中的 `/etc/uci-defaults/99-custom.sh`，在设备首次启动时执行一次。

当前用途包括：
- 设置 LAN IP 与子网掩码
- 调整 SSH 接口绑定
- 写入固件描述信息

注意：
- 工作流会在构建阶段把 `config.sh` 中的 `ip_address/netmask` 注入该脚本
- `uci-defaults` 脚本执行后会被系统清理，不会长期保留

## 构建流程（GitHub Actions）

工作流文件：`.github/workflows/build-openwrt-image.yml`

### 触发方式

- 手动触发（`workflow_dispatch`）
- 参数 `profile` 可选：
  - `all`：自动扫描 `build/*/config.sh` 生成构建矩阵
  - 指定设备：仅构建对应 profile

### 执行顺序

1. 读取触发参数并生成矩阵（`prepare-matrix`）
2. 按设备并行执行构建（`build`）
3. 读取 `build/<profile>/config.sh` 导出设备变量
4. 根据 `version + device_targets` 组合 URL，下载对应 ImageBuilder
5. 自动识别压缩格式并解包
6. 合并软件包：
   - 先加载 `config/default_packages.sh`
   - 再加载 `build/<profile>/packages.sh`
   - 最后加载 `build/<profile>/extra_packages.sh`（如存在，自动下载预编译包并追加）
7. 复制并修补 `99-custom.sh`（注入 IP/掩码）
8. 执行：

```bash
make -j$(nproc) image PROFILE="$profile" PACKAGES="$PACKAGES" FILES="files/" V=s
```

9. 收集 `imagebuilder/bin/targets` 下固件与校验相关文件到 `artifacts/<profile>/`
10. 将 `artifacts/<profile>/` 内文件发布到 GitHub Release

## 软件包叠加规则

最终 `PACKAGES` 由三层叠加：
- 第一层：`config/default_packages.sh`（全设备通用）
- 第二层：`build/<profile>/packages.sh`（设备官方源包）
- 第三层：`build/<profile>/extra_packages.sh`（设备自定义包/第三方包，支持自动下载预编译包）

因此建议：
- 通用工具放全局
- 硬件驱动和强耦合插件放设备级

## 如何新增一个设备

以新增 `new_device` 为例：

1. 创建目录：`build/new_device/`
2. 新建 `config.sh`，至少包含：
   - `profile`
   - `targets`
   - `arch`
   - `version`
   - `ip_address`
   - `netmask`
3. 新建 `packages.sh`，填入 immortalwrt 官方源包
4. 新建 `extra_packages.sh`，填入自定义插件（可选）
5. 新建 `99-custom.sh`，写入首次启动初始化逻辑
6. 提交后在 Actions 中选择：
   - `profile=all`（自动发现）或
   - `profile=new_device`（单设备）

### 最小 config.sh 示例

```bash
#!/bin/bash
export profile="new_device_profile"
export targets="mediatek/filogic"
export arch="aarch64_cortex-a53"
export version="24.10.5"
export ip_address="192.168.2.1"
export netmask="255.255.255.0"
```

## 当前已配置设备

- `cmcc_rax3000me`
- `qihoo_360t7`

## 构建产物与命名

工作流会先将构建结果整理到：

```text
artifacts/<profile>/
```

上传前会对附件名进行整理：
- 删除前缀 `immortalwrt-`
- 删除文件名中的架构段（例如 `mediatek-filogic-`）

然后再上传为 Release 附件。

Release Tag 命名规则：

```text
<sdk_version>-<profile>
```

Release Name 命名规则：

```text
<sdk_version>-<profile>
```

## 常见问题与排查

### 1) `No build profiles found under build/`

原因：
- `build/` 下没有符合约定的设备目录
- 设备目录缺少 `config.sh`

排查：
- 检查目录层级是否为 `build/<profile>/config.sh`

### 2) ImageBuilder 下载失败

原因：
- `version` 与 `device_targets` 不匹配
- 上游命名规则变动

排查：
- 核对 `config.sh` 中版本和 target
- 手动访问下载目录确认文件名

### 3) 构建报 PROFILE 不存在

原因：
- `profile` 与官方 profile 不一致

排查：
- 在对应 target 的 ImageBuilder 中执行 `make info` 查看可用 profile
- 修正 `profile`

## 使用建议

- 优先保持 `config.sh` 中四个字段一致性：`profile`、`targets`、`arch`、`version`
- 将网络初始化与系统个性化放在 `99-custom.sh`
- 新增设备时先最小化包列表，构建成功后再逐步加包

## 免责声明

本仓库仅提供自动化构建流程示例。刷机有风险，请确保已了解对应设备的刷写与救援方法。