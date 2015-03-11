include stdlib
include epel

include nfs::server

file { '/data':
    ensure => 'directory',
    owner => 'vagrant',
    mode => 750
}

nfs::server::export { '/data':
    ensure => 'mounted',
    clients => '10.10.10.4/24(rw,insecure,async,no_all_squash) localhost(rw)',
    require => File['/data']
}

service { "iptables": 
    ensure => "stopped",
}

class {"condor":
    master => true
}

class {'ganglia':
    controller => true,
    require => Class['epel']
}


