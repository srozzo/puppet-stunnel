# Class: stunnel::install
#

class stunnel::install (
  $package_ensure,
  $package_name
){

  package { 'stunnel' :
    ensure => $package_ensure,
    name   => $package_name
  }
  
}

# vim: ts=2 sw=2
