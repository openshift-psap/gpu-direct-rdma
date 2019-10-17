FROM registry.access.redhat.com/ubi8/ubi

WORKDIR /root 

RUN dnf -y install kmod binutils

COPY dpdk/kernel/linux/gdrdrv/x86_64/gdrdrv.ko .
COPY dpdk/kernel/linux/gdrdrv/x86_64/insmod.sh .
