include stdlib
include epel

include nfs::client
nfs::client::mount { '/data':
    server => '10.10.10.3',
    share => '/data'
}

service { "iptables": 
    ensure => "stopped",
}

class {"condor":
    master => false
}

class {"ganglia":
    require => Class['epel']
}

class {"r":
    require => Class['epel']
}

r::installp {"forecast":}
