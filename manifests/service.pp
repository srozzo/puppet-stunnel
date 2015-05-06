# Class: stunnel::service
#

# Note there is no init script bundled with the stunnel package on
# CentOS
class stunnel::service (
  $service_ensure,
  $service_name
) {

  service { 'stunnel' :
    ensure     => $service_ensure,
    name       => $service_name,
    hasstatus  => false,
    hasrestart => true
  }

  # Debian stunnel packages have an extraneous file the must be edited
  # to enable the stunnel service
  if (downcase($::osfamily) == 'debian') {
    if ($service_ensure == true or $service_ensure == 'running') {
      augeas{'deb_svc_enable' :
        context => '/files',
        changes => 'set etc/default/stunnel4/ENABLED 1',
        notify  => Service['stunnel']
      }
    } else {
      augeas{'deb_svc_disable' :
        context => '/files',
        changes => 'set etc/default/stunnel4/ENABLED 0',
        notify  => Service['stunnel']
      }
    }
  }

}

# vim: ts=2 sw=2
