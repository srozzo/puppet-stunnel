# Class: stunnel::config
#

class stunnel::config (
  $global_options,
  $service_conf,
  $tunnels
) {

  # Stunnel configuration
  concat { $service_conf :
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0640'
  }

  # Global configuration options
  concat::fragment { '00-global-options' :
    content => template('stunnel/stunnel.conf.global.erb'),
    target  => $service_conf
  }

  # Create service tunnels
  create_resources(stunnel::tunnel, $tunnels)

  # Create directory for chroot if specified
  if (has_key($global_options, 'chroot')) {

    if (has_key($global_options, 'setuid')) {
      $service_user = $global_options['setuid']
    } else {
      $service_user = 'root'
    }

    if (has_key($global_options, 'setgid')) {
      $service_group = $global_options['setgid']
    } else {
      $service_group = 'root'
    }

    file { $global_options['chroot'] :
      ensure => directory,
      owner  => $service_user,
      group  => $service_group,
      mode   => '0600'
    }
  }
}

# vim: ts=2 sw=2
