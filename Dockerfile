# syntax=docker/dockerfile:1
from ubuntu:jammy

WORKDIR /twrp

RUN useradd -ms /bin/bash docker_build -u 1000

RUN chown -R docker_build /twrp
# Install dependencies
RUN apt update
RUN apt install git repo python-is-python3 rsync device-tree-compiler -y

USER docker_build

RUN git config --global user.email "nothanks@email.com"
RUN git config --global user.name "twrp_build"

RUN repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1

RUN repo sync

RUN mkdir out