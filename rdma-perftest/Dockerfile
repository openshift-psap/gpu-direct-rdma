FROM docker.io/nvidia/cuda:10.2-devel-ubi8

WORKDIR /root

ENV MLX=MLNX_OFED_LINUX-4.7-1.0.0.1-rhel8.0-x86_64

RUN dnf -y install make gcc wget perl createrepo pciutils python36-devel ethtool lsof elfutils-libelf-devel rpm-build kernel-rpm-macros python36 tk numactl-libs libmnl tcl binutils kmod procps git autoconf automake libtool net-tools

RUN wget http://content.mellanox.com/ofed/MLNX_OFED-4.7-1.0.0.1/$MLX.tgz

RUN tar xf $MLX.tgz

WORKDIR $MLX

RUN ./mlnxofedinstall --upstream-libs --dpdk --with-mft  --distro rhel8.0 --user-space-only --force --without-fw-update


RUN dnf -y group install "Development Tools"

WORKDIR /root

RUN git clone https://github.com/linux-rdma/perftest.git

WORKDIR /root/perftest


ENV CUDA_H_PATH=/usr/local/cuda/include/cuda.h

RUN ./autogen.sh
RUN ./configure
RUN make install


# COPY FROM BUILDER ETC .... 
RUN dnf -y install hwloc

# nvidia-container-toolkit
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

