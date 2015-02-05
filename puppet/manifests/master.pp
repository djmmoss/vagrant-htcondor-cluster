include stdlib

stage { 'pre':
  before => Stage['main'],
  }

service { "iptables": 
    ensure => "stopped",
}

class {"htcondor" :
    is_ce => true,
    is_manager => true,
    managers => ["10.2.0.2"],
    worker_nodes => ["10.2.0.*"],
    stage => 'pre'
}
