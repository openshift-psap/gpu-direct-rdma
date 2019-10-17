FROM registry.access.redhat.com/ubi8/ubi

WORKDIR /root 

ENV MLX=MLNX_OFED_LINUX-4.7-1.0.0.1-rhel8.0-x86_64

RUN dnf -y install make gcc wget perl createrepo kernel-devel kernel-core pciutils python36-devel ethtool lsof elfutils-libelf-devel rpm-build kernel-rpm-macros python36 tk numactl-libs libmnl tcl

RUN wget http://content.mellanox.com/ofed/MLNX_OFED-4.7-1.0.0.1/$MLX.tgz

RUN tar xf $MLX.tgz

WORKDIR $MLX

RUN ./mlnxofedinstall --upstream-libs --dpdk --with-mft --add-kernel-support


