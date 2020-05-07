$script = <<-SCRIPT
sudo apt-get install g++
sudo apt-get install cmake
sudo apt-get install git
sudo apt-get install tmux
sudo useradd developer
sudo usermod -aG sudo developer
echo "developer:developer" | sudo chpasswd
sudo chown -R developer /home/developer
SCRIPT

Vagrant.configure("2") do |config|

  config.vagrant.plugins = ["vagrant-vbguest"]

  config.vm.box = "bento/ubuntu-18.04"
  config.vm.network "public_network"
  config.vm.synced_folder('shared', '/vagrant', type: 'rsync')

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "2048"
  end

  config.vm.provision "shell", inline: $script, privileged: true

  config.ssh.extra_args = "-tt"

end
