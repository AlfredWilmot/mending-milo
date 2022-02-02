FROM osrf/ros:dashing-desktop
# FROM nvidia/cuda:11.0-base
# Guide on reunning GUI applications in docker containers (X11 display sharing); tested with gimp, works, but doesn't work with ROS guis (gazebo/ rviz)
# https://www.youtube.com/watch?v=cMsIT2otEjA&ab_channel=dotslashrun

# ENV GAZEBO_MASTER_URI="http://172.18.0.2:11345" 

# install video driver requirements
RUN apt-get update \
    && apt-get install -y \
        mesa-utils \
        libgl1-mesa-glx \
        dbus \
        wget

# install gazebo9
# RUN apt-get -y install curl \
#     && curl -sSL http://get.gazebosim.org | sh \
#     && apt-get install -y ros-dashing-gazebo9-*

RUN sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list' \
    && wget https://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -

RUN apt-get update \
    && apt-get install gazebo9


CMD ["gazebo", "--verbose"]

#1) install container with nvidia drivers
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html

#2) how to use nvidia container-toolkit with docker
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/user-guide.html

# test (
# docker run --rm --name gzclient --gpus all --privileged -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix gazebo-test

####
####
####
# followed this guide and it works! (https://www.pugetsystems.com/labs/hpc/NVIDIA-Docker2-with-OpenGL-and-X-Display-Output-1527/)
# docker run --rm -it --gpus all -e DISPLAY -e XAUTHORITY -e NVIDIA_DRIVER_CAPABILITIES=all -v /tmp/.X11-unix:/tmp/.X11-unix:ro --name gzclient x11-test