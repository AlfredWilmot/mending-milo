### install convenience packages
# peek, slack, terminator, joplin, vlc, obs
sudo apt-get update \
&& sudo snap install slack --classic \
&& sudo snap install joplin-james-carroll \
&& sudo add-apt-repository ppa:peek-developers/stable -y \
&& sudo apt-get install -y terminator peek

### install vs code on Ubuntu (https://code.visualstudio.com/docs/setup/linux)

# manually install the repo and key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

# update package cache and install
sudo apt install -y apt-transport-https
sudo apt update
sudo apt -y install code


### install docker engine (https://docs.docker.com/engine/install/ubuntu/)
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# add the official docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# "set up the stable repo"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# update package cache and install 
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# post-install steps (https://docs.docker.com/engine/install/linux-postinstall/)
sudo groupadd docker
sudo usermod -aG docker $USER

# activate group changes (without needing to log in/out for changes to take effect)
newgrp docker

# configure docker to start on boot
sudo systemctl enable docker.service
sudo systemctl enable containerd.service



### install docker-compose (https://phoenixnap.com/kb/install-docker-compose-on-ubuntu-20-04)

# get latest stable release
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# make the downloaded binray executable
sudo chmod +x /usr/local/bin/docker-compose

# install (previous step may be redundant)
sudo apt-get install -y docker-compose

# verify installation
sudo docker–compose --version


### give docker containers (clients) access the X11 display on the host machine
xhost +