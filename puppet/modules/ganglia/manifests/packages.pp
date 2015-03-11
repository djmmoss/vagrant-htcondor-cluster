class ganglia::packages($controller = false) {
    
    case $::osfamily {
        'Debian' : {
            package { 'ganglia-monitor':
                ensure => present
            }

            if $controller {
                package { 'rrdtool':
                    ensure => present
                }

                package { 'gmetad':
                    ensure => present
                }

                package { 'ganglia-webfrontend':
                    ensure => present
                }
            }
        }
        'RedHat' : {
            package { 'ganglia-gmond':
                ensure => present
            }

            if $controller {
                package { 'ganglia-gmetad':
                    ensure => present
                }

                package { 'ganglia-web':
                    ensure => present
                }
            }
        }
    }
}
