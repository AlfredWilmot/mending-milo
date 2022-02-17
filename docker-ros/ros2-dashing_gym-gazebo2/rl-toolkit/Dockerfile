# FROM ros:dashing-ros-base
FROM osrf/ros:dashing-desktop

# prepare the workspace
RUN mkdir -p /root/ros2_mara_ws/src
WORKDIR /root/ros2_mara_ws

# update package list and install latest stable versions
RUN apt update && apt upgrade -y

# core packages
RUN apt install -y \
    wget \
    python3-pip \
    python3-sip-dev \
    python-dateutil

#Gazebo
RUN apt install -y ros-dashing-*gazebo*

RUN wget https://raw.githubusercontent.com/AcutronicRobotics/MARA/dashing/mara-ros2.repos && vcs import src < mara-ros2.repos \
    && wget https://raw.githubusercontent.com/AcutronicRobotics/gym-gazebo2/dashing/provision/additional-repos.repos && vcs import src < additional-repos.repos 

#Generete HRIM packages
RUN cd ~/ros2_mara_ws/src/HRIM \
    && pip3 install hrim \
    && hrim generate models/actuator/servo/servo.xml \
    && hrim generate models/actuator/gripper/gripper.xml

# installing some ros-dashing packages
RUN apt install -y \
    ros-dashing-rttest \
    # using cyclonedds instead of opensplice (https://discourse.ros.org/t/opensplice-move-to-eclipse-cyclone-dds-in-ros-2/12370)
    ros-dashing-rmw-cyclonedds-cpp \
    && rm -rf /var/lib/apt/lists/*

# install gym
RUN pip3 install \
    gym 
    # tensorflow \
    # scipy \
    # billiard \
    # psutil \
    # transforms3d \
    # matplotlib \
    # pandas



# Build the workspace
RUN bash -c " cd /root/ros2_mara_ws \
\
    && source /opt/ros/dashing/setup.bash && \
\
    colcon build --merge-install \
        --parallel-workers $(nproc) \
        --packages-ignore   gazebo_msgs gazebo_dev gazebo_ros \
                            gazebo_plugins gazebo_ros_pkgs \
                            orocos_kinematics_dynamics individual_trajectories_bridge"

# not sure what this is for ...
RUN touch /root/ros2_mara_ws/install/share/orocos_kdl/local_setup.sh /root/ros2_mara_ws/install/share/orocos_kdl/local_setup.bash 

# gym
# RUN cd /root && git clone https://github.com/openai/gym && cd /root/gym && pip3 install -e . 

WORKDIR /root/

#gym-gazebo2
RUN git clone -b dashing https://github.com/AcutronicRobotics/gym-gazebo2 && \
    cd /root/gym-gazebo2 && \
    pip3 install -e . 

#ros2learn
RUN git clone -b dashing https://github.com/AcutronicRobotics/ros2learn.git && \
    cd /root/ros2learn/ && \
    git submodule update --init --recursive \
    && cd /root/ros2learn/algorithms/baselines && \
    pip3 install -e .

RUN apt-get install -y python3-tk

WORKDIR /root/ros2learn/experiments/examples/MARA/

# load and export environement variables
COPY .env /

COPY rl_entrypoint.sh /

RUN echo 'source /rl_entrypoint.sh' >> ~/.bashrc 

# hard-coding some environmental variables to make sure the scripts work at runtime 

ENV GAZEBO_MODEL_PATH=/usr/share/gazebo-11/models::/root/ros2_mara_ws/install/share
ENV GAZEBO_MODEL_DATABASE_URI=http://models.gazebosim.org
ENV OGRE_RESOURCE_PATH=/usr/lib/x86_64-linux-gnu/OGRE-1.9.0
ENV GAZEBO_RESOURCE_PATH=/usr/share/gazebo-11:
ENV GAZEBO_MASTER_URI=http://localhost:11345
ENV GAZEBO_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/gazebo-11/plugins::/root/ros2_mara_ws/install/lib

ENV ROS_DISTRO=dashing
ENV ROS_VERSION=2
ENV ROS_PYTHON_VERSION=3

ENV LD_LIBRARY_PATH=/root/ros2_mara_ws/install/lib:/opt/ros/dashing/opt/yaml_cpp_vendor/lib:/usr/lib:/opt/ros/dashing/lib:/usr/lib/x86_64-linux-gnu/gazebo-11/plugins
ENV AMENT_PREFIX_PATH=/root/ros2_mara_ws/install:/opt/ros/dashing

ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
ENV PKG_CONFIG_PATH=/root/ros2_mara_ws/install/lib/pkgconfig

ENV CMAKE_PREFIX_PATH=/root/ros2_mara_ws/install
ENV COLCON_PREFIX_PATH=/root/ros2_mara_ws/install

ENV PATH=$PATH:/opt/ros/dashing/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PYTHONPATH=$PYTHONPATH:/root/ros2_mara_ws/install/lib/python3.8/site-packages:/opt/ros/dashing/lib/python3.8/site-packages:/root/ros2_mara_ws/install/lib/python3/dist-packages:/usr/lib/python3.8/site-packages:/usr/lib/python3/dist-packages



# ENTRYPOINT ["/rl_entrypoint.sh"]
# CMD ["bash"]