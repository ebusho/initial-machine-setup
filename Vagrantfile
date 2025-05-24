Vagrant.configure("2") do |config|
  config.vm.define "initial-machine-setup-box" do |fedora|
    fedora.vm.box = "onlyoffice/base-fedora41"
    fedora.vm.box_version = "1.0.0"
    fedora.vm.provider "virtualbox"
    fedora.vm.provision "shell", inline: <<-SHELL
      dnf install -y python3-libdnf5
    SHELL
  end
end
