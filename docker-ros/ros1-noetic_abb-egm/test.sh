# rocker --x11 --nvidia \
#   --oyr-run-arg " --net=host --ipc=host --pid=host" \
#   cogrob/omnimapper_ros \
#   ros2 launch omnimapper_ros realsense.launch.xml \
#     use_rosbag:=false


# build the Dockerfile in the /noetic-abb-egm folder: 
docker build --tag abb-egm .

# setup a network: 
docker network create ros-net

#---------------#
# Bootstrapping #
#---------------#

# run container while giving it access to ethernet ports/ usb devices
docker run -it --rm \
    --network ros-net \
    --name master \
    --privileged -v /dev/bus/usb:/dev/bus/usb \
    -v "$(pwd)"/shared-volumes:/home/catkin_ws/src \
    -p 6511:6511/udp \
    -p 80:80/tcp \
    abb-egm \
    bash

# run these in the master container
catkin_make_isolated \
&& source devel_isolated/setup.bash && roslaunch abb_robot_bringup_examples ex2_rws_and_egm_6axis_robot.launch robot_ip:=192.168.125.1


# enable roscontrol via the switch controller service
rosservice call /egm/controller_manager/switch_controller "start_controllers: [joint_position_controller]
stop_controllers: ['']
strictness: 1
start_asap: false
timeout: 0.0"

# run the joint-trajectory controller rqt plugin
docker run --rm -it \
    --network ros-net \
    --name rqt-joint-traj-controller \
    --gpus all \
    -e DISPLAY -e XAUTHORITY -e NVIDIA_DRIVER_CAPABILITIES=all \
    -e ROS_MASTER_URI="http://172.19.0.2:11311" \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v "$(pwd)"/shared-volumes:/home/catkin_ws/src \
    abb-egm \
    bash
    
catkin_make_isolated && source devel_isolated/setup.bash && rqt -s joint_trajectory_controller






# inspecting a ros container (example)
docker exec -it master bash
source /ros_entrypoint.sh


# check IP addresses on host computer (includes that of any active docker containers)
hostname -I

