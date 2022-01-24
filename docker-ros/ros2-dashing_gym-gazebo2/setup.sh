# get the base image from docker hub (acutronicrobotics/gym-gazebo2)
docker pull acutronicrobotics/gym-gazebo2

# get the desktop version of ros2-dashing
docker pull osrf/ros:dashing-desktop

docker network create ros-net

# spin-up a container
docker run -it --rm \
    --name master \
    osrf/ros:dashing-desktop \
    bash

# deep cleanse!!
docker system prune -a
