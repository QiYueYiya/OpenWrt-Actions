FROM ubuntu:22.04

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ='Asia/Shanghai'

RUN apt update -y
RUN apt full-upgrade -y
RUN apt install -y ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
  bzip2 ccache clang cmake cpio curl device-tree-compiler ecj fastjar flex gawk gettext gcc-multilib \
  g++-multilib git gnutls-dev gperf haveged help2man intltool lib32gcc-s1 libc6-dev-i386 libelf-dev \
  libglib2.0-dev libgmp3-dev libltdl-dev libmpc-dev libmpfr-dev libncurses-dev libpython3-dev \
  libreadline-dev libssl-dev libtool libyaml-dev libz-dev lld llvm lrzsz mkisofs msmtp nano \
  ninja-build p7zip p7zip-full patch pkgconf python3 python3-pip python3-ply python3-docutils \
  python3-pyelftools qemu-utils re2c rsync scons squashfs-tools subversion swig texinfo uglifyjs \
  upx-ucl unzip vim wget xmlto xxd zlib1g-dev zstd jq sudo bash
RUN apt autoremove --purge
RUN apt clean

RUN groupadd -g 128 docker || true
RUN groupadd -g 4 adm || true
RUN groupadd -g 101 systemd-journal || true
RUN useradd -m -u 1001 -g docker -G adm,systemd-journal runner || true
RUN echo 'runner ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER runner

WORKDIR /workspace
