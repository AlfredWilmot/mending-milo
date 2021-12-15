# mending-milo
Here I will outline my journey of learning how to improve the portability of my code

### Use Docker to run ROS distros
1) Install [docker engine](https://docs.docker.com/engine/install/ubuntu/)
   - Update pkg index: 
     - `sudo apt-get update` 
   - Install prerequisite pkgs: 
     - `sudo apt-get install ca-certificates curl gnupg lsb-release`
   - Add the official Docker GPG key: 
     - `curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg`
   - Install docker engine: 
     - `sudo apt-get update` 
     - `sudo apt-get install docker*`
   - Make a docker group and add myself to it:
     - `sudo groupadd docker`
     - `sudo usermod -aG docker $USER`
     - `newgroup docker`
   - Had to run the following cmd:
     - `sudo chmod 666 /var/run/docker.sock`

### Task (2)
set-up and run the [ros2learn docker container](https://github.com/AcutronicRobotics/ros2learn/tree/dashing/docker)

- Notes
    1) Installation instructions for [ROS2 Dashing](https://docs.ros.org/en/dashing/Installation/Ubuntu-Install-Debians.html)
    2) Setting-up [Python venvs and venvwrappers](https://realpython.com/python-virtual-environments-a-primer/)
    3) Supplement documentation with gifs using [Peek](https://vitux.com/install-peek-animated-gif-recorder-on-ubuntu/)
    4) Installing and managing [different version of Python3](https://www.itsupportwale.com/blog/how-to-upgrade-to-python-3-7-on-ubuntu-18-10/)
    5) Installing and using [Docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04) 


ToDo:
- make a script that automates the installation of python venv stuff

<sub><sup>
Tired of sitting around mending broken code?
Have you tried going to the gym and [rebuilding milo](https://www.goodreads.com/en/book/show/54303312-rebuilding-milo) instead? 
</sup></sub>
