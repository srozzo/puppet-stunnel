# Class: stunnel::params
#

class stunnel::params {

  # OS Agnostic defaults
  $package_ensure = present
  $service_conf   = '/etc/stunnel/stunnel.conf'
  $service_ensure = running

  # OS specific defaults
  case downcase($::osfamily) {
    'debian' : {
      $package_name = 'stunnel4'
      $service_name = 'stunnel4'
    }
    default : {
      $package_name = 'stunnel'
      $service_name = 'stunnel'
    }
  }
}

# vim: ts=2 sw=2
