# rocker --x11 --nvidia \
#   --oyr-run-arg " --net=host --ipc=host --pid=host" \
#   cogrob/omnimapper_ros \
#   ros2 launch omnimapper_ros realsense.launch.xml \
#     use_rosbag:=false


# build the Dockerfile in the /noetic-abb-egm folder: 
docker build --tag ros:abb-egm .

# setup a network: 
docker network create ros-net

#---------------#
# Bootstrapping #
#---------------#

# setup ROS master over the ros-net network:
docker run -it --rm \
    --net ros-net \
    --name master \
    ros:abb-egm \
    roscore

# run container while giving it access to ethernet ports/ usb devices
docker run -it --rm \
    --name master \
    --privileged -v /dev/bus/usb:/dev/bus/usb \
    -p 6511:6511/udp \
    -p 80:80/tcp \
    ros:abb-egm

# with shared volume (for development)
docker run -it --rm \
    --net ros-net \
    --name master \
    -v `pwd`:/home/catkin_ws \
    ros:abb-egm \
    bash

# run rviz using rocker (requires ROS master in ros:noetic)
rocker --x11 --nvidia \
    --net ros-net \
    --name rviz \
    --oyr-run-arg "--env ROS_MASTER_URI=http://master:11311" \
    ros:abb-egm \
    rviz

# inspecting a ros container (example)
docker exec -it master bash
source /ros_entrypoint.sh


# check IP addresses on host computer (includes that of any active docker containers)
hostname -I

