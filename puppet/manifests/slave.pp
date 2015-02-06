include stdlib
include epel

stage { "pre":
  before => Stage["main"],
  }

package { "device-mapper-libs":
    ensure => latest,
}

service { "iptables": 
    ensure => "stopped",
}

class { "docker" :
    tcp_bind    => 'tcp://127.0.0.1:4243',
    socket_bind => 'unix:///var/run/docker.sock',
    }

docker::image{ "jimwhite/condor-centos6" :}

docker::run { "condor1" :
    image => "jimwhite/condor-centos6",
    hostname => "slave1.1"
}

#class {"htcondor" :
    #managers => ["10.2.0.2"],
    #worker_nodes => ["10.2.0.*"],
    #stage => 'pre'
#}

#exec { "startd":
    #command => "/usr/sbin/condor_startd",
#}
