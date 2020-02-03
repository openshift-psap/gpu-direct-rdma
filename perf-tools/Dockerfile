FROM registry.access.redhat.com/ubi8/ubi

WORKDIR /root 

ENV KERNEL_VERSION=4.18.0-147.3.1.el8_1.x86_64

RUN dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN dnf -y install tuna htop  

RUN mkdir -p /lib/modules/${KERNEL_VERSION}
RUN ln -sf /usr/src/kernels/${KERNEL_VERSION} /lib/modules/${KERNEL_VERSION}/build
RUN touch /lib/modules/${KERNEL_VERSION}/modules.order
RUN touch /lib/modules/${KERNEL_VERSION}/modules.builtin



