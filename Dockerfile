FROM dorowu/ubuntu-desktop-lxde-vnc:focal-arm64
LABEL maintainer="Tiryoh<tiryoh@gmail.com>"

RUN apt-get update -q && \
    apt-get upgrade -yq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq wget curl git build-essential vim sudo lsb-release locales bash-completion tzdata gosu && \
    rm -rf /var/lib/apt/lists/*
RUN useradd --create-home --home-dir /home/ubuntu --shell /bin/bash --user-group --groups adm,sudo ubuntu && \
    echo ubuntu:ubuntu | chpasswd && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY ./ros-noetic-desktop.sh /ros-noetic-desktop.sh
RUN mkdir -p /tmp/ros_setup_scripts_ubuntu 
RUN mv /ros-noetic-desktop.sh /tmp/ros_setup_scripts_ubuntu/ 
RUN chmod +x /tmp/ros_setup_scripts_ubuntu/ros-noetic-desktop.sh
RUN gosu ubuntu /tmp/ros_setup_scripts_ubuntu/ros-noetic-desktop.sh
RUN rm -rf /var/lib/apt/lists/*
ENV USER ubuntu