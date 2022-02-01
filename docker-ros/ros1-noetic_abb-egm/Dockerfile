FROM osrf/ros:noetic-desktop

RUN apt-get update && apt-get install -y \
    ros-noetic-desktop-full \
    && rm -rf /var/lib/apt/lists/

# below is sourcing a fix from https://stackoverflow.com/questions/20635472/using-the-run-instruction-in-a-dockerfile-with-source-does-not-work
SHELL ["/bin/bash", "-c"]

# ----------------------------------------------------------------------------------------------------- #
# installing deps for running the abb_robot_driver (https://github.com/ros-industrial/abb_robot_driver) #
# ----------------------------------------------------------------------------------------------------- #

# install vcstool (https://github.com/dirk-thomas/vcstool#how-to-install-vcstool)
RUN apt-get update  && apt-get install -y curl python3-vcstool git \ 
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add - 

# Use vcstool to clone all required repositories into the 'src' space.
# update local rosdep database and install any missing deps
# Some deps are plain CMake (not catkin pkgs) so cannot build using vanilla catkin
RUN mkdir -p /home/catkin_ws/src \
    && vcs import /home/catkin_ws/src --input https://github.com/ros-industrial/abb_robot_driver/raw/master/pkgs.repos 

RUN rosdep update

RUN rosdep install --from-paths /home/catkin_ws/src --ignore-src

# build the catkin_ws (NOTE: https://stackoverflow.com/questions/55941916/unable-to-execute-catkin-commands-using-run-in-dockerfile)
RUN . /opt/ros/noetic/setup.sh && \
    catkin_make_isolated -C /home/catkin_ws

WORKDIR /home/catkin_ws

CMD source devel_isolated/setup.bash && roslaunch abb_robot_bringup_examples ex2_rws_and_egm_6axis_robot.launch robot_ip:=192.168.125.1