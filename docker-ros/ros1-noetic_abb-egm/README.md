# ros1-noetic_abb-egm

This outlines a ROS demo for receiving ABB joint data via RWS and EGM, and sending joint position commands to the ABB via the EGM interface, the key points are outlined below:

- If the Image is not pulled from a repository, you will need to build the docker file locally.\
This may take some time and will require an internet connection.

<table>
<tr>
<td> Building the image from scratch and assigning it the tag "abb-egm". Make sure you're in the same directory as the `Dockerfile` you're trying to build.  </td>
</tr>
<tr>
<td>

```bash:
docker build -t abb-egm .
```

</td>
</tr>
</table>


- The host machine needs to connect to the ABB controller via an Ethernet connection, and some connection parameters need to be configured on the robot. The ROS application assumes that the `robot_ip` is `192.168.125.1`\
To use the RWS and EGM features on your ABB with your ROS machine, make sure that the EGM port is set to 6511 (default used by ROS application), and that the IP address that the EGM packets are sent to are that of your host machine. 

<table>
<tr>
<td> Basic cmd for checking private IP addresses on host machine </td> <td> more detailed information showing the connections on your host machine (look out for GENERAL.TYPE and GENERAL.CONNECTION being "Ethernet" and "Wired" respectively) </td>
</tr>
<tr>
<td>

```bash:
hostname -I
```

</td> 
<td> 

```bash:
nmcli -p device show
```

</td>
</tr>
</table>


- Once the docker image is either built or pulled, the container is ready to be deployed. This first container will be for running the *ex2_rws_and_egm_6axis_robot.launch* example script 

<table>
<tr>
<td> Deploy a docker container called "master" using the abb-egm image. This container runs the main rws-egm script from the abb-driver github repo, and connects to the ABB robot via the Ethernet port. The RWS and EGM packets can be investigated by checking the relevant rostopics.
</td>
<td>

```bash:
docker run -it --rm \
    --name master \
    --privileged -v /dev/bus/usb:/dev/bus/usb \
    -p 6511:6511/udp \
    -p 80:80/tcp \
    abb-egm 
```

</td>
</tr>
<tr>
<td> Make sure the "master" container is running, open another terminal and open-up a terminal instance of the container to investigate the rostopics of interest.
</td>
<td>

```bash:
docker exec -it master bash
```

</td>
</tr>
<tr>
<td> Once inside the container, make sure to setup the environmental variables that ROS needs to work in the particular terminal instance you just opened up.
</td>
<td>

```bash:
source /ros_entrypoint.sh
```

</td>
</tr>

<tr>
<td> The topic of interest can be inspected by filtering for particular types of topics, such as egm.
</td>
<td>

```bash:
rostopic list | grep egm
```
</td>
</tr>

<tr>
<td> Data from a particular topic can be echo'd to the terminal. When typing out the topic you want to see you can press the tab button twice to autocomplete if there is only one possible option, or otherwise display the available options if there is more than one. This is a typical feature of terminal interfaces, and applies to Unix command-line terminals in general.
</td>
<td>

```bash:
rostopic echo /egm<tab><tab>
```
</td>
</tr>
</table>