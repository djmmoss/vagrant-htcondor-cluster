include stdlib
include epel

file { "/etc/environment":
    content => inline_template("http_proxy=http://web-cache.usyd.edu.au:8080")
}

service { "iptables": 
    ensure => "stopped",
}

class {"condor":}

class condor {
    $major_release = regsubst($::operatingsystemrelease, '^(\d+)\.\d+$', '\1')

    yumrepo { 'htcondor-stable':
        descr => "HTCondor Stable RPM Repository for Redhat Enterprise Linux ${major_release}",
        baseurl => "http://research.cs.wisc.edu/htcondor/yum/stable/rhel${major_release}",
        enabled => 1,
        gpgcheck => 0,
        priority => "99",
        exclude => 'condor.i386, condor.i686',
        before => [Package['condor']],
    }
    package { "condor":
        ensure => present,
        before => Exec['condor-configure']
    }

    exec { "condor-configure" :
        command => "/usr/sbin/condor_configure --prefix=/usr --type=submit,execute --central-manager=master"
    }

}

