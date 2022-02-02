# get the base image from docker hub (acutronicrobotics/gym-gazebo2)
docker pull acutronicrobotics/gym-gazebo2
# get the desktop version of ros2-dashing
docker pull osrf/ros:dashing-desktop

# setup the network
docker network create ros-net

# ----------------------#
# RL Toolking container #
# ----------------------#

# spin-up the gym-gazebo2 conatiner and run the ./examples/MARA/gg_random.py test script
# docker run -it --rm \
#     --net ros-net \
#     --name train-test \
#     acutronicrobotics/gym-gazebo2 


# (slightly modified spin-up instructions from https://github.com/AcutronicRobotics/gym-gazebo2/tree/dashing/docker)
docker rm gg2 || true \
    && docker run -it \
    --net ros-net \
    --name=gg2 \
    -h gym-gazebo2 -v `pwd`:/tmp/gym-gazebo2 \
    acutronicrobotics/gym-gazebo2

# Run inside the docker container to load visual models and run training sim
cp -r /root/ros2_mara_ws /tmp/gym-gazebo2 \
    && cd ~/gym-gazebo2/examples/MARA \
    && python3 gg_random.py


# --------------------------#
# Simulation/ viz container #
# --------------------------#

# spin-up a container for visualization (make sure rocker venv is active!)
rocker --x11 --nvidia \
    --net ros-net \
    --name visualization \
    osrf/ros:dashing-desktop \
    bash

# make sure gazebo is installed on in the visualization container
apt-get update && apt-get install -y ros-dashing-gazebo-ros-pkgs

# ------------#
# Helper cmds #
# ------------#

# deep cleanse!!
docker system prune -a

# give docker containers (clients) access the X11 display on the host machine
xhost +