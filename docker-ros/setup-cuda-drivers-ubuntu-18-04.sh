# Installation cmds: https://docs.nvidia.com/datacenter/tesla/tesla-installation-notes/index.html#ubuntu-lts
sudo apt-get install linux-headers-$(uname -r)
distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-$distribution.pin
sudo mv cuda-$distribution.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/7fa2af80.pub
echo "deb http://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda.list
sudo apt-get update
sudo apt-get -y install cuda-drivers

# Post install actions: https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#post-installation-actions
export PATH=/usr/local/cuda-11.6/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-11.6/lib64\
                         ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# Starting "NVIDIA Persistence Daemon" as root (supports persistence of driver state across CUDA jobs)
# (this seems to fail, but the drivers seem to load just fine anyway?)
/usr/bin/nvidia-persistenced --verbose


# Verifying installation version
cat /proc/driver/nvidia/version



# Installing the NVIDIA Container Tookit: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker 
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker

# verify installation by running the nvidia-smi docker container
# NOTE: may need to restart system first
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi