FROM nvidia/cuda:10.2-devel-ubi8

ENV KERNEL_VERSION=4.18.0-147.3.1.el8_1.x86_64
ENV MLX=MLNX_OFED_LINUX-4.7-1.0.0.1-rhel8.0-x86_64
ENV RTE_KERNELDIR=/lib/modules/${KERNEL_VERSION}/build

RUN mkdir -p /lib/modules/${KERNEL_VERSION}
RUN ln -sf /usr/src/kernels/${KERNEL_VERSION} /lib/modules/${KERNEL_VERSION}/build
RUN touch /lib/modules/${KERNEL_VERSION}/modules.order
RUN touch /lib/modules/${KERNEL_VERSION}/modules.builtin

RUN yum groupinstall -y 'Development Tools'
RUN yum install -y autoconf automake binutils bison flex gcc gcc-c++ gettext libtool make patch pkgconfig \
                   redhat-rpm-config rpm-build rpm-sign byacc cscope ctags diffstat elfutils      \ 
                   gcc-gfortran git intltool patchutils  subversion swig systemtap
RUN yum install -y wget numactl-devel pciutils  net-tools tk python36 lsof tcl libmnl ethtool \
                   elfutils-libelf-devel iproute libnl3 "kernel-devel-uname-r == ${KERNEL_VERSION}" yum-utils

## RUN yum-config-manager --enable rhel-server-rhscl-7-rpms && yum install -y devtoolset-7-gcc-c++.x86_64
# ENV PATH=/opt/rh/devtoolset-7/root/usr/bin:$PATH

RUN wget http://content.mellanox.com/ofed/MLNX_OFED-4.7-1.0.0.1/$MLX.tgz
RUN tar xf $MLX.tgz
RUN rm $MLX.tgz
RUN $MLX/mlnxofedinstall --dpdk --upstream-libs --user-space-only --force --without-fw-update --distro rhel8.0

WORKDIR /work
COPY . .

RUN ls -l 

ENV RTE_SDK /work
ENV RTE_TARGET x86_64-native-linuxapp-gcc

RUN wget http://mirror.centos.org/centos/7/os/x86_64/Packages/libmnl-devel-1.0.3-7.el7.x86_64.rpm
RUN rpm -i libmnl-devel-1.0.3-7.el7.x86_64.rpm --nodeps
RUN ln -s /usr/lib64/libmnl.so.0 /usr/lib/libmnl.so

RUN sed -ri 's,(RTE_NV=).*,\1y,' config/common_base
RUN sed -ri 's,(MLX5_PMD=).*,\1y,' config/common_base

RUN make config T=$RTE_TARGET O=$RTE_TARGET
RUN make -j $(nproc --all) T=$RTE_TARGET O=$RTE_TARGET || exit 0
