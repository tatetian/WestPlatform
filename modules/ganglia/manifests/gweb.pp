class ganglia::gweb {
  package {'php5':
    ensure => installed
  }
  package {'apache2':
    ensure => installed
  }
  #package {'rrdtool':
  #  ensure => installed
  #}
  package {'ganglia-webfrontend':
    ensure => installed,
    require => [ Package['php5'], Package['rrdtool']]
  }
  #exec {'create softlink to /var/www/html':
  #  require => [ Package['ganglia-webfrontend']],
  #  command => 'sudo ln -s /usr/share/ganglia-webfrontend /var/www/html/ganglia',
  #  path => ['/bin', '/usr/bin'],
  #  notify => Service['apache2']
  #}
  file {'/var/www/html/ganglia':
    require => [ Package['ganglia-webfrontend']],
    ensure => 'link',
    target => '/usr/share/ganglia-webfrontend',
  }
  service {'apache2':
    ensure => running,
    enable => true,
    require => [ Package['ganglia-webfrontend'], Package['apache2']]
  }
}
