FROM osrf/ros:noetic-desktop

RUN apt-get update && apt-get install -y \
    ros-noetic-desktop-full \
    && rm -rf /var/lib/apt/lists/

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

RUN rosdep update \ 
    && rosdep install --from-paths /home/catkin_ws/src --ignore-src --rosdistro noetic 

# build the catkin_ws (NOTE: https://stackoverflow.com/questions/55941916/unable-to-execute-catkin-commands-using-run-in-dockerfile)
RUN . /opt/ros/noetic/setup.sh && \
    catkin_make_isolated -C /home/catkin_ws

WORKDIR /home/catkin_ws

CMD ["source", "devel_isolated/setup.bash"]