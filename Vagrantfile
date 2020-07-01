# -*- mode: ruby -*-
# vi: set ft=ruby  :


machines = {
  "database-01" => {"memory" => "2048", "cpu" => "2", "ip" => "10", "image" => "centos/8", "disk-new-size" => "70GB"},
  "docker-swarm-01" => {"memory" => "2048", "cpu" => "2", "ip" => "20", "image" => "centos/8", "disk-new-size" => "50GB"},
  "docker-swarm-02" => {"memory" => "2048", "cpu" => "2", "ip" => "30", "image" => "centos/8", "disk-new-size" => "50GB"},
  "docker-swarm-03" => {"memory" => "2048", "cpu" => "2", "ip" => "40", "image" => "centos/8", "disk-new-size" => "50GB"}
}

Vagrant.configure("2") do |config|

  config.vm.box_check_update = false
  config.vm.boot_timeout = 600
  
  machines.each do |name, conf|
    config.vm.define "#{name}" do |machine|
      machine.vm.box = "#{conf["image"]}"
      machine.vm.hostname = "#{name}.lab.example"
      machine.disksize.size = conf["disk-new-size"]
      machine.vm.network "private_network", ip: "172.16.17.#{conf["ip"]}"
      machine.vm.provider "virtualbox" do |vb|
        vb.name = "#{name}"
        vb.memory = conf["memory"]
        vb.cpus = conf["cpu"]
        vb.customize ["modifyvm", :id, "--groups", "/lab-monitoramento"]
      end
    end
  end
  config.vm.provision "shell", path: "provision/script.sh"
end