# Reinforcement Learning in ROS2

### Task (1): set-up and run the [ros2learn docker container](https://github.com/AcutronicRobotics/ros2learn/tree/dashing/docker)

- TODO:
    1) Add the [ros2learn](https://github.com/AcutronicRobotics/ros2learn.git) repo to the ws [x]
        - `git submodule add -b dashing https://github.com/AcutronicRobotics/ros2learn.git`
        - `git submodule update --remote --recursive` 
    2) setup python venv and wrapper []
        - `pip install virtualenv`
        - `virtualenv -p /usr/bin/python3.7 venv-ros2-rl`
        - `pip install virtualenvwrapper`
    3) build the docker image following these instructions, using a python3.7 venv []

- Dependency issues
    1) Gazebo git repo must be in the `dashing` branch (otherwise clocon won't build)
    2) Master branch of OpenAI-gym git repo is only compatible with >=Python3.7 

## A test

- [install docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04) on Ubuntu 18.04 
- pull the latest gym-gazebo2 docker image: \
`docker pull acutronicrobotics/gym-gazebo2:latest`
- [install gazebo](http://gazebosim.org/tutorials?tut=install_ubuntu#Defaultinstallation:one-liner) on the host system: \
  `curl -sSL http://get.gazebosim.org | sh`
- set-up the docker container: \
    `docker run -it --name gg2 acutronicrobotics/gym-gazebo2:latest`
- sets-up an instance of this container session in the terminal; can launch several sessions from other terminals once this one is up using: \
    `docker exec -it gg2 bash`
- if this container is exited prematurely, and you're simply not ready to let go, just start it again and access via `exec`:
  - `docker start gg2`
  - `docker exec -it gg2 bash`
- to see a list of any actively running containers:
  - `docker ps`
- to see a list of all conatainers (running or otherwise):
  - `docker ps -a`