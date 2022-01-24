# Containerizing ROS applications with Docker
Herein are a set of instructions for simplifying the deployment of ROS applications through Docker. \
Each section focuses on a particular implementation task, such as enabling GUIs or orchestrating multiple ros containers.

---

## Enable GUI-capable Dockerized ROS applications using Rocker 
---

### __Setup Guide__
- This [demo](https://github.com/CogRob/omnimapper_ros) was used as a starting point to determine the requirements for this task
- install the following dependencies on an Ubuntu 18.04 host machine:
  - [Docker](https://get.docker.com/) installation script referenced in the `omnimapper_ros` git repo
  - [nvidia-docker](https://github.com/NVIDIA/nvidia-docker), requires docker engine and nvidia drivers to be installed on the host machine:
    - [nvidia-drivers](https://docs.nvidia.com/datacenter/tesla/tesla-installation-notes/index.html) installation guide-- this took quite some time to finish (~30mins)
    - [post installation actions](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#post-installation-actions) guide
    - [nvidia container tool-kit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker) setup instructions
  - [rocker](https://github.com/osrf/rocker) installation instructions
  - [off-your-rocker](https://github.com/sloretz/off-your-rocker) addon for rocker
    - simply ran `pip install git+https://github.com/sloretz/off-your-rocker.git` with the rocker venv activated to intsall this extension.

### __Notes__
- This was a generally time-consuming process, but is worthwhile to get GUI applications working in docker containers. 
- This "Setup guide" needs to be refined as there were a few set-up details that were not clear from these external docs. 
- Make sure to set-up and be in a local python virtual environment `rocker_venv` as is specified in the rocker documentation, when running rocker commands. 
- Use the `rocker` cmd in the same way you use the `docker` cmd. \
For instance, to run `rviz` in a ROS2 container, the following terminal cmd can be used: `rocker --nvidia --x11 osrf/ros:crystal-desktop rviz2` 

In order to run rviz in a ROS1 container, the container needs to be networked to a seperate container running `roscore`. \
So next I will go over orchestrating ROS nodes across multiple docker containers, and subsequently look at getting this implementation architecture to work with rocker.

---

## Guide for orchestrating Multi-container ROS nodes
---
### __Setup Guide__
- [Video tutorial](https://www.youtube.com/watch?v=9xqekKwzmV8) on building and running multiple ROS nodes in seperate containers (instead of running all the ROS applications in a single container like a simpleton)
- [git repo](https://github.com/ruffsl/ros_docker_demos/blob/master/multicontainer/README.md) from ruffsl corresponding to tutorial
- Ensure the following dependencies are installed on the host-machine:
  - [Docker]() (try installing via snaps `snap install docker` as is suggested in this [ROS+Docker+Pi4](https://www.youtube.com/watch?v=UySK0AggZZY) video tutorial)
  - [Docker Compose](https://docs.docker.com/compose/)

### __Notes__
- Install [docker compose](https://docs.docker.com/compose/install/) to manage multiple docker containers.