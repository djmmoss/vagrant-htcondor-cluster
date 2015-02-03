#class {"r":}

#r::installp{"xts":}
#r::installp{"Rcpp":}
include stdlib

resource { "firewall" :
    purge => true
}

class {"htcondor" :
    is_worker => true,
    managers => ["10.0.0.2"],
    worker_nodes => ["10.0.0.*"]
}
