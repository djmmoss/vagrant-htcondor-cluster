Vagrant.configure("2") do |config|
    # Number of Slaves
    numSlaves = 2

    # Private Network Address
    ipAddressPrefix = "10.0.0.2"
    
    # Default Box
    config.vm.box = "centos6_4_puppet"
    config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20131103.box"

    # Master Box
    # This Box contains the web client and communicates to the slave machines running HTCondor
    config.vm.define "master" do |master|
        # Forward Web Port
        master.vm.network :forwarded_port, host: 3000, guest:80
        
        # Set Private Network
        master.vm.network :private_network, ip: ipAddressPrefix

        # Set Virtual Box Name
        master.vm.provider "virtualbox" do |v|
            v.name = "Backtest Master"
        end

        # Provision with Puppet
        master.vm.provision "puppet" do |puppet|
            puppet.manifests_path = "puppet/manifests"
            puppet.module_path = "puppet/modules"
            puppet.manifest_file = "master.pp"
        end
    end

    # Slave Boxes
    # This Boxes do all of the work.
    1.upto(numSlaves) do |num|
        slaveName = ("slave" + num.to_s).to_sym
        config.vm.define slaveName do |slave|
            # Set Private Network
            slave.vm.network :private_network, ip: ipAddressPrefix + num.to_s

            # Set Virtual Box Name
            slave.vm.provider "virtualbox" do |v|
                v.name = "Backtest Slave " + num.to_s
            end
        

            # Provision Slaves with Puppet
            slave.vm.provision "puppet" do |puppet|
                puppet.manifests_path = "puppet/manifests"
                puppet.module_path = "puppet/modules"
                puppet.manifest_file = "slave.pp"
            end
        end
    end
end
