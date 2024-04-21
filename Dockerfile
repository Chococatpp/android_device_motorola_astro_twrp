# syntax=docker/dockerfile:1
from ubuntu:jammy

WORKDIR /twrp

RUN useradd -ms /bin/bash docker_build -u 1000

RUN chown -R docker_build /twrp
# Install dependencies
RUN apt update

# Second line is for Kernel build
RUN apt install -y git repo python-is-python3 rsync device-tree-compiler \
                   libc6-dev-i386 libssl-dev zip

USER docker_build

RUN git config --global user.email "nothanks@email.com"
RUN git config --global user.name "twrp_build"

RUN repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1

RUN repo sync

# Clone kernel
RUN git clone https://github.com/sdm710-motorola/android_kernel_motorola_sdm710 -b android-10 kernel/motorola/sdm710

RUN mkdir out