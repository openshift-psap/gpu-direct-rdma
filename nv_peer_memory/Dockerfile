FROM registry.access.redhat.com/ubi8/ubi

ENV NVPM=nvidia_peer_memory-1.0-8.x86_64.rpm

RUN mkdir /lib/modules/$(uname -r)
RUN ln -s /usr/src/kernels/$(uname -r) /lib/modules/$(uname -r)/build
RUN touch /lib/modules/$(uname -r)/modules.order
RUN touch /lib/modules/$(uname -r)/modules.builtin


WORKDIR /root

COPY $NVPM .

RUN dnf -y install kmod binutils perl

RUN rpm -ivh $NVPM

RUN depmod -a 
