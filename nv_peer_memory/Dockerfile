FROM registry.access.redhat.com/ubi8/ubi as BUILDER

ENV KERNEL_VERSION=4.18.0-147.3.1.el8_1.x86_64

COPY nvidia-440.33.01 /usr/src/nvidia-440.33.01
COPY ofa_kernel /usr/src/ofa_kernel
COPY lib /lib/

WORKDIR /root
RUN dnf -y group install "Development Tools"
RUN dnf -y install kernel-devel-${KERNEL_VERSION} kernel-headers-${KERNEL_VERSION} kmod binutils perl elfutils-libelf-devel
RUN git clone https://github.com/Mellanox/nv_peer_memory.git

WORKDIR /root/nv_peer_memory
RUN sed -i 's/updates\/dkms/kernel\/drivers\/video/g' create_nv.symvers.sh 
RUN ./build_module.sh

RUN mkdir -p /lib/modules/${KERNEL_VERSION}
RUN ln -sf /usr/src/kernels/${KERNEL_VERSION} /lib/modules/${KERNEL_VERSION}/build
RUN touch /lib/modules/${KERNEL_VERSION}/modules.order
RUN touch /lib/modules/${KERNEL_VERSION}/modules.builtin

RUN rpmbuild --rebuild --define 'KVERSION 4.18.0-147.3.1.el8_1.x86_64' /tmp/nvidia_peer_memory-*

RUN ls -l /root/rpmbuild/RPMS/x86_64/nvidia_peer_memory-*.rpm

FROM registry.access.redhat.com/ubi8/ubi

ENV KERNEL_VERSION=4.18.0-147.3.1.el8_1.x86_64

RUN mkdir -p /lib/modules/${KERNEL_VERSION}
RUN touch /lib/modules/${KERNEL_VERSION}/modules.order
RUN touch /lib/modules/${KERNEL_VERSION}/modules.builtin

WORKDIR /root

COPY --from=BUILDER /root/rpmbuild/RPMS/x86_64/nvidia_peer_memory-*.rpm  .

RUN dnf -y --setopt=install_weak_deps=False --best install kmod binutils perl
RUN rpm  -ivh nvidia_peer_memory-*.rpm 

