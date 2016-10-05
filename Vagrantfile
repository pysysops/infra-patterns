# -*- mode: ruby -*-
# vi: set ft=ruby :
require "socket"
PRIVATE_SUBNET="172.16.252"

host_hostname = Socket.gethostname

nodes = {
  :base => {
    :hostname => "prd-base-001.dc1.example.com",
    :ipaddress => "#{PRIVATE_SUBNET}.5",
    :facts => {
      :server_env => "prd",
      :server_type => "base",
    }
  },
  :puppet => {
    :hostname => "prd-cm-001.dc1.example.com",
    :ipaddress => "#{PRIVATE_SUBNET}.10",
    :facts => {
      :server_env => "prd",
      :server_type => "cm",
    }
  },
  :jenkins => {
    :hostname => "prd-ci-001.dc1.example.com",
    :ipaddress => "#{PRIVATE_SUBNET}.11",
    :facts => {
      :server_env => "prd",
      :server_type => "ci",
    }
  },
  :jenkins_slave => {
    :hostname => "prd-ci-002.dc1.example.com",
    :ipaddress => "#{PRIVATE_SUBNET}.12",
    :facts => {
      :server_env => "prd",
      :server_type => "ci",
    }
  },
  :gitlab => {
    :hostname => "prd-git-001.dc1.example.com",
    :ipaddress => "#{PRIVATE_SUBNET}.13",
    :facts => {
      :server_env => "prd",
      :server_type => "git",
    }
  },
  :squid => {
    :hostname => "prd-prx-001.dc1.example.com",
    :ipaddress => "#{PRIVATE_SUBNET}.250",
    :facts => {
      :server_env => "prd",
      :server_type => "prx",
    }
  },
  :dns => {
    :hostname => "prd-dns-001.dc1.example.com",
    :ipaddress => "#{PRIVATE_SUBNET}.53",
    :facts => {
      :server_env => "prd",
      :server_type => "dns",
    }
  },
}

Vagrant.configure(2) do |config|
  config.vm.box = "puppetlabs/centos-7.2-64-puppet"
  config.ssh.forward_agent = true

  # Trick Vagrant / Puppet 4 into using environments properly
  config.vm.synced_folder "puppet", "/tmp/vagrant-puppet/environments/production"

  config.vm.provider :virtualbox do  |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--memory", 256]
    vb.customize ["modifyvm", :id, "--cpus", 1]
  end

  nodes.each do |node, options|
    $facter_values = {}
    config.vm.define node do |node_config|
      node_config.vm.network :private_network, ip: options[:ipaddress]

      if options.has_key?(:forwardport)
        node_config.vm.network :forwarded_port, guest: options[:forwardport][:guest], host: options[:forwardport][:host]
      end

      node_config.vm.hostname = options[:hostname]

      node_config.vm.provision :puppet do |puppet|
        puppet.hiera_config_path = "puppet/hiera/hiera_vagrant.yaml"
        puppet.environment = "production"
        puppet.environment_path = "puppet/environments"
        puppet.manifest_file = "vagrant.pp"
        puppet.manifests_path = "puppet/manifests"
        puppet.options = "-tv"
        if options.has_key?("facts")
          puppet.facter = options[:facts]
        end
        puppet.facter["vagrant"] = "1"
        puppet.facter["environment"] = "production"
        if not puppet.facter.has_key?("server_type")
          puppet.facter["server_type"] = "base"
        end
      end

    end
  end

end
