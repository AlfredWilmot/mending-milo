# Reinforcement Learning in ROS2

### Task (1): set-up and run the [ros2learn docker container](https://github.com/AcutronicRobotics/ros2learn/tree/dashing/docker)

- TODO:
    1) Add the [ros2learn](https://github.com/AcutronicRobotics/ros2learn.git) repo to the ws [x]
        - `git submodule add -b dashing https://github.com/AcutronicRobotics/ros2learn.git`
        - `git submodule update --remote --recursive` 
    2) setup python venv and wrapper []
    3) build the docker image following these instructions, using a python3.7 venv []

- Dependency issues
    1) Gazebo git repo must be in the `dashing` branch (otherwise clocon won't build)
    2) Master branch of OpenAI-gym git repo is only compatible with >=Python3.7 