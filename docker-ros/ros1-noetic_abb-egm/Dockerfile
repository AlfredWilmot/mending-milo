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
# (using my own forked repo as I had to change the the egm controller to a JointTrajectoryController)
RUN mkdir -p /home/catkin_ws/src \
    && vcs import /home/catkin_ws/src --input https://github.com/AlfredWilmot/abb_robot_driver/raw/master/pkgs.repos 


# updating package manifest and installing anything missing packages
RUN rosdep update \
    && rosdep install -y --from-paths /home/catkin_ws/src --ignore-src

# build the catkin_ws (NOTE: https://stackoverflow.com/questions/55941916/unable-to-execute-catkin-commands-using-run-in-dockerfile)
# Some deps are plain CMake (not catkin pkgs) so cannot build using vanilla catkin
RUN . /opt/ros/noetic/setup.sh && \
    catkin_make_isolated -C /home/catkin_ws

# installing other deps for the abb packages
RUN sudo apt-get install -y \
    ros-noetic-industrial-robot-simulator \
    ros-noetic-trac-ik-kinematics-plugin \
    ros-noetic-simple-message \
    ros-noetic-industrial-robot-client
    
RUN sudo apt-get install -y \
    ros-noetic-moveit-fake-controller-manager \
    ros-noetic-moveit-planners-ompl \
    ros-noetic-moveit-ros-move-group \
    ros-noetic-moveit-ros-visualization \
    ros-noetic-moveit-simple-controller-manager

WORKDIR /home/catkin_ws

# -------------------------- #
# Installing additional deps #

# run rqt when a rosmaster is active, and select the joint-trajectory-controller plugin to use this
RUN sudo apt-get install ros-noetic-ros-controllers ros-noetic-joint-trajectory-controller ros-noetic-rqt-joint-trajectory-controller ros-noetic-ros-control -y


# destroy the src files so these can be developed by the host and mounted to the container (for development)
# RUN rm -rf /home/catkin_ws/src/abb_robot_driver/abb_robot_bringup_examples/*

# launch the rws/egm test script with the given robot IP when running this images as a container (unless bash is specified in docker run)
CMD source devel_isolated/setup.bash && roslaunch abb_robot_bringup_examples ex2_rws_and_egm_6axis_robot.launch robot_ip:=192.168.125.1