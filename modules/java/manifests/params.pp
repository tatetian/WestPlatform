class java::params {

  $java_version = $::hostname ? {
    default => '1.7.0_71',
  }
  
  $java_base = $::hostname ? {
    default => '/opt/java',
  }
  
}
