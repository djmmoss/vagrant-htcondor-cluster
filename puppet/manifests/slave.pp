class {"r":}

#r::installp{"xts":}
#r::installp{"Rcpp":}
include stdlib

stage { "pre":
  before => Stage["main"],
  }

service { "iptables": 
    ensure => "stopped",
}

class { "docker" :
}


#class {"htcondor" :
    #managers => ["10.2.0.2"],
    #worker_nodes => ["10.2.0.*"],
    #stage => 'pre'
#}

#exec { "startd":
    #command => "/usr/sbin/condor_startd",
#}
