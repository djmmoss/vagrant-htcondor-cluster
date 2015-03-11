#Define the list of machines
slurm_cluster = {
    :controller => {
        :hostname => "controller",
        :ipaddress => "10.10.10.3",
        :type => "controller"
    },
    :server1 => {
        :hostname => "server1",
        :ipaddress => "10.10.10.4",
        :type => "node"
    },
    :server2 => {
        :hostname => "server2",
        :ipaddress => "10.10.10.5",
        :type => "node"
    }
}

#Provisioning inline script
$script = <<SCRIPT
echo "10.10.10.3    controller" >> /etc/hosts
echo "10.10.10.4    server1" >> /etc/hosts
echo "10.10.10.5    server2" >> /etc/hosts
SCRIPT

Vagrant.configure("2") do |global_config|
    slurm_cluster.each_pair do |name, options|
        global_config.vm.define name do |config|
            #VM configurations
            config.vm.box = "puppetlabs/centos-6.5-64-puppet"
            config.vm.hostname = "#{name}"
            config.vm.network :private_network, ip: options[:ipaddress]
            config.vm.synced_folder ".", "/vagrant", type: "nfs"

            #VM specifications
            config.vm.provider :virtualbox do |v|
                v.customize ["modifyvm", :id, "--memory", "512"]
            end

            #VM provisioning
            config.vm.provision :shell,
                :inline => $script

            if options[:type] == "controller"
                config.vm.network "forwarded_port", guest: 80, host: 3000
                config.vm.provision :puppet do |puppet|
                    puppet.manifest_file  = "controller.pp"
                    puppet.manifests_path = "puppet/manifests"
                    puppet.module_path = "puppet/modules"
                end
            else
                config.vm.provision :puppet do |puppet|
                    puppet.manifest_file  = "node.pp"
                    puppet.manifests_path = "puppet/manifests"
                    puppet.module_path = "puppet/modules"
                end
            end


        end
    end
end
