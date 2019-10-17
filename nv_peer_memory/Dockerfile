FROM registry.access.redhat.com/ubi8/ubi

ENV NVPM=nvidia_peer_memory-1.0-8.x86_64.rpm

WORKDIR /root

COPY $NVPM .

RUN dnf -y install kmod binutils

