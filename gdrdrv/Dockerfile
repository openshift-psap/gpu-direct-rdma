FROM registry.access.redhat.com/ubi8/ubi as BUILDER

ENV KERNEL_VERSION=4.18.0-147.3.1.el8_1.x86_64

WORKDIR /root 

COPY nvidia_dpdk.tgz .
RUN tar xvpfz nvidia_dpdk.tgz

COPY nvidia-440.33.01 /usr/src/nvidia-440.33.01

RUN dnf -y group install "Development Tools"
RUN dnf -y install kernel-devel-${KERNEL_VERSION} kernel-headers-${KERNEL_VERSION} kmod binutils perl elfutils-libelf-devel

RUN mkdir /lib/modules/${KERNEL_VERSION}
RUN ln -s /usr/src/kernels/${KERNEL_VERSION} /lib/modules/${KERNEL_VERSION}/build
RUN touch /lib/modules/${KERNEL_VERSION}/modules.order
RUN touch /lib/modules/${KERNEL_VERSION}/modules.builtin

WORKDIR dpdk/kernel/linux/gdrdrv/x86_64
RUN make KVER=${KERNEL_VERSION}
RUN sed -i 's/sudo//g' insmod.sh


FROM registry.access.redhat.com/ubi8/ubi

WORKDIR /root

RUN dnf -y install kmod binutils

COPY --from=BUILDER /root/dpdk/kernel/linux/gdrdrv/x86_64/gdrdrv.ko .
COPY --from=BUILDER /root/dpdk/kernel/linux/gdrdrv/x86_64/insmod.sh .
