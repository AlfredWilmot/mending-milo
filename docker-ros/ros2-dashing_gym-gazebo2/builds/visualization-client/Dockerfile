# FROM acutronicrobotics/gym-gazebo2
FROM osrf/ros:dashing-desktop
FROM nvidia/cuda
# Guide on reunning GUI applications in docker containers (X11 display sharing); tested with gimp, works, but doesn't work with ROS guis (gazebo/ rviz)
# https://www.youtube.com/watch?v=cMsIT2otEjA&ab_channel=dotslashrun

# ENV GAZEBO_MASTER_URI="http://172.18.0.2:11345" 
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

# install video driver requirements
RUN apt-get update && apt-get install -y mesa-utils and libgl1-mesa-glx dbus

# install gazebo9
RUN apt-get -y install curl \
    && curl -sSL http://get.gazebosim.org | sh \
    && sudo apt-get install -y ros-dashing-gazebo9-*

CMD ["gazebo"]

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
# docker run --rm -it --runtime=nvidia -e DISPLAY -e XAUTHORITY -e NVIDIA_DRIVER_CAPABILITIES=all -v /tmp/.X11-unix:/tmp/.X11-unix:ro gazebo-test