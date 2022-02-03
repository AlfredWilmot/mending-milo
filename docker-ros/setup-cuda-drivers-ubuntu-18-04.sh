# following this tutorial: "Workstation setup for docker with new NVIDIA container toolkit" (2019):
# https://www.pugetsystems.com/labs/hpc/Workstation-Setup-for-Docker-with-the-New-NVIDIA-Container-Toolkit-nvidia-docker2-is-deprecated-1568/

sudo apt-get remove --purge \
    docker \
    docker-engine \
    docker.io \
    containerd \
    runc

sudo add-apt-repository ppa:graphics-drivers/ppa

sudo apt-get update

sudo apt-get install -y build-essential dkms

sudo apt-get install -y nvidia-driver-510 

sudo apt-get purge -y nvidia-docker2

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common


curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io

distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
&& curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
&& curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list \
&& sudo apt-get update \
&& sudo apt-get install nvidia-container-toolkit \
&& sudo systemctl restart docker


# verify installation
sudo docker run --gpus all --rm nvidia/cuda:11.5.0-devel-ubuntu18.04 nvidia-smi
