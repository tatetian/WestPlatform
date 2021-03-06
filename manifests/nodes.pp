#hadoop params
$h_version = '2.2.0'
$h_group = 'hadoop'
$h_user = 'hadoop'
$h_base = "/home/$h_user"
$h_master = 'hadoop-master'
$h_slaves = ['hadoop-slave1']
$h_hosts = "172.16.0.119 hadoop-master\n172.16.0.120 hadoop-slave1\n"

#spark params
$sc_version = '2.10.4'
$sp_version = '1.0.0-bin-hadoop2'
$sp_slaves = $h_slaves

node 'hadoop-master' {
  class { 'hadoop':
    hadoop_version => $h_version,
    hadoop_group => $h_group,
    hadoop_user => $h_user,
    hadoop_base => $h_base,
    hadoop_master => $h_master,
    hadoop_slaves => $h_slaves,
    hosts => $h_hosts,    
  }

  class { 'hadoop::cluster':
    hadoop_user => $h_user,
    hadoop_base => $h_base,
    hadoop_version => $h_version,
  }

  class { 'spark':
    hadoop_user => $h_user,
    hadoop_group => $h_group,
    hadoop_base => $h_base,
    scala_version => $sc_version,
    spark_version => $sp_version,
    spark_slaves => $sp_slaves,
  }

  class {'ganglia':
    mod => 'master',
  }
}

node /hadoop-slave\d*/ {
  class { 'hadoop':
    hadoop_version => $h_version,
    hadoop_group => $h_group,
    hadoop_user => $h_user,
    hadoop_base => $h_base,
    hadoop_master => $h_master,
    hadoop_slaves => $h_slaves,
    hosts => $h_hosts,
  }

  class { 'spark':
    hadoop_user => $h_user,
    hadoop_group => $h_group,
    hadoop_base => $h_base,
    scala_version => $sc_version,
    spark_version => $sp_version,
    spark_slaves => $sp_slaves,
  }
  class {'ganglia':
    mod => 'slave',
  }
}
