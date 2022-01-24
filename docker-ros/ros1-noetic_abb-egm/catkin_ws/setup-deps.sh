# install deps for running the abb_robot_driver (https://github.com/ros-industrial/abb_robot_driver)

## install vcstool (https://github.com/dirk-thomas/vcstool#how-to-install-vcstool)
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt install curl # if you haven't already installed curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install python3-vcstool
sudo apt-get install git


# Use vcstool to clone all required repositories into the 'src' space.
vcs import src --input https://github.com/ros-industrial/abb_robot_driver/raw/master/pkgs.repos

# update local rosdep database
rosdep update

# intsall any missing deps
rosdep install --from-paths src --ignore-src --rosdistro noetic

# Some deps are plain CMake (not catkin pkgs) so cannot build using vanilla catkin
catkin_make_isolated