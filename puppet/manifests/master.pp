include stdlib

resource { "firewall" :
    purge => true
}

class {"htcondor" :
    is_ce => true,
    is_manager => true,
    managers => ["10.0.0.2"],
    worker_nodes => ["10.0.0.*"]
}
