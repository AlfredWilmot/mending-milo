#!/bin/bash
# set -e 

# setup ros2 environment
source "/opt/ros/foxy/setup.bash"
exec "$@"

# load environmental variables 
export $(cat /.env)

# MARA stuff
source ~/ros2_mara_ws/install/setup.bash
source /usr/share/gazebo-11/setup.sh