class ganglia($mod='slave'){
  case $mod{
    'slave':{
      include ganglia::gmond
    }
    'master':{
      include ganglia::gmond
      include ganglia::gmetad
      include ganglia::gweb
    }
  }
}
