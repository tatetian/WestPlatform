class java {

  require java::params
	
  #Set Java Directory And Untar Package
	
  file { "$java::params::java_base":
    ensure => directory,
    owner => 'root',
    group => 'root',
    alias => 'java-base',
  }
        
  file { "${java::params::java_base}/jdk${java::params::java_version}.tar.gz":
    mode => 0644,
    owner => 'root',
    group => 'root',
    source => "puppet:///modules/java/jdk${java::params::java_version}.tar.gz",
    alias => 'java-source-tgz',
    before => Exec['untar-java'],
    require => File['java-base'],
  }
	
  exec { "untar jdk${java::params::java_version}.tar.gz":
    command => "tar -zxvf jdk${java::params::java_version}.tar.gz",
    cwd => "${java::params::java_base}",
    path => ['/bin', '/usr/bin', '/usr/sbin'],
    creates => "${java::params::java_base}/jdk${java::params::java_version}",
    alias => 'untar-java',
    refreshonly => true,
    subscribe => File['java-source-tgz'],
    before => File['java-app-dir'],
  }
	
  file { "${java::params::java_base}/jdk${java::params::java_version}":
    ensure => directory,
    mode => 0644,
    owner => 'root',
    group => 'root',
    alias => 'java-app-dir',
    require => Exec['untar-java'],
  }

  #Set Java Environment

  file { '/etc/profile.d/java.sh':
    ensure => present,
    owner => 'root',
    group => 'root',
    alias => 'java-profile',
    content => template('java/java_profile.erb'),
  }
	
}
