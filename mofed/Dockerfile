FROM registry.access.redhat.com/ubi8/ubi

WORKDIR /root 

ENV KERNEL_VERSION=4.18.0-147.3.1.el8_1.x86_64
ENV MLX=MLNX_OFED_LINUX-4.7-1.0.0.1-rhel8.0-x86_64

RUN dnf -y install make gcc wget perl createrepo kernel-devel-${KERNEL_VERSION} pciutils python36-devel ethtool lsof elfutils-libelf-devel rpm-build kernel-rpm-macros python36 tk numactl-libs libmnl tcl binutils kmod procps git autoconf automake libtool net-tools

RUN mkdir -p /lib/modules/${KERNEL_VERSION}
RUN ln -sf /usr/src/kernels/${KERNEL_VERSION} /lib/modules/${KERNEL_VERSION}/build
RUN touch /lib/modules/${KERNEL_VERSION}/modules.order
RUN touch /lib/modules/${KERNEL_VERSION}/modules.builtin

RUN wget http://content.mellanox.com/ofed/MLNX_OFED-4.7-1.0.0.1/$MLX.tgz

RUN tar xf $MLX.tgz

WORKDIR $MLX

RUN ./mlnxofedinstall --upstream-libs --dpdk --with-mft --add-kernel-support --distro rhel8.0 --kernel ${KERNEL_VERSION} --kernel-sources /usr/src/kernels/${KERNEL_VERSION}

