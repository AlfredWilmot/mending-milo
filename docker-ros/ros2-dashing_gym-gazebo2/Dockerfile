FROM acutronicrobotics/gym-gazebo2

RUN apt-get update && cp -r /root/ros2_mara_ws /tmp/gym-gazebo2

WORKDIR /root/

RUN git clone -b dashing https://github.com/AcutronicRobotics/ros2learn.git && \
    cd ros2learn/ && \
    git submodule update --init --recursive

RUN pip3 install --upgrade pip


RUN cd ros2learn/algorithms/baselines && pip3 install -e .

RUN pip3 install \
    matplotlib \
    pandas

RUN apt-get install -y python3-tk

WORKDIR /root/ros2learn/experiments/examples/MARA/

# CMD [ "python3" ]

# ENTRYPOINT [ "" ]

# ENTRYPOINT ["train_acktr.py", "-g"]

# docker run --rm -it \
#     --name gg2-2 \
#     --gpus all \
#     -e DISPLAY -e XAUTHORITY -e NVIDIA_DRIVER_CAPABILITIES=all \
#     -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
#     gg2-toolkit 



#############################
# don't forget to "xhost +" on host machine to ensure container access to X11 display drivers!
#############################