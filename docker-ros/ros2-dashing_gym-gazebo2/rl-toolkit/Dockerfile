FROM ros:foxy-ros-base

# what python modules and ROS packages do I need to install to get the gg2 rl-toolkit to work?
# what environmental variables need to be set-up? 
# make a .env file, install the rosdeps, make a requirements.txt file.

# prepare the workspace
RUN mkdir -p /root/ros2_mara_ws/src
WORKDIR /root/ros2_mara_ws

# update package list and install latest stable versions
RUN apt update && apt upgrade -y

# core packages
RUN apt install -y \
    wget \
    python3-pip

#Gazebo
RUN apt install -y ros-foxy-gazebo*

RUN wget https://raw.githubusercontent.com/AcutronicRobotics/MARA/dashing/mara-ros2.repos && vcs import src < mara-ros2.repos \
    && wget https://raw.githubusercontent.com/AcutronicRobotics/gym-gazebo2/dashing/provision/additional-repos.repos && vcs import src < additional-repos.repos 

#Generete HRIM packages
RUN cd ~/ros2_mara_ws/src/HRIM \
    && pip3 install hrim \
    && hrim generate models/actuator/servo/servo.xml \
    && hrim generate models/actuator/gripper/gripper.xml

# installing other missing packages
RUN apt install -y \
    ros-foxy-rttest \
    python3-sip-dev 

# installing python packages
RUN pip3 install \
    gym \
    scipy \
    billiard \
    psutil

# Build the workspace
RUN bash -c " cd /root/ros2_mara_ws \
\
    && source /opt/ros/foxy/setup.bash && \
\
    colcon build --merge-install \
        --parallel-workers $(nproc) \
        --packages-ignore   gazebo_msgs gazebo_dev gazebo_ros \
                            control_msgs gazebo_plugins gazebo_ros_pkgs \
                            orocos_kinematics_dynamics individual_trajectories_bridge"

# not sure what this is for ...
RUN touch /root/ros2_mara_ws/install/share/orocos_kdl/local_setup.sh /root/ros2_mara_ws/install/share/orocos_kdl/local_setup.bash 

# gym
# RUN cd /root && git clone https://github.com/openai/gym && cd /root/gym && pip3 install -e . 
#gym-gazebo2
RUN cd /root && git clone -b dashing https://github.com/AcutronicRobotics/gym-gazebo2 && cd /root/gym-gazebo2 && pip3 install -e . 
#Load provisioning script
# RUN echo 'source /root/gym-gazebo2/provision/mara_setup.sh' >> ~/.bashrc 

WORKDIR /root/gym-gazebo2/provision/
COPY ros2-mara-setup.sh .
RUN echo 'source /root/gym-gazebo2/provision/ros2-mara-setup.sh' >> ~/.bashrc 

# load and export environement variables
COPY .env .
RUN echo 'export $(cat /root/gym-gazebo2/provision/.env)' >> ~/.bashrc 

# ENTRYPOINT export $(cat .env) && bash
ENTRYPOINT [ "bash" ]