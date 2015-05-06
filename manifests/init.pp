# Class: stunnel
#
#  Installs and manages stunnel package
#

class stunnel (
  $global_options,
  $tunnels,
  $package_ensure     = $stunnel::params::package_ensure,
  $package_name       = $stunnel::params::package_name,
  $service_conf       = $stunnel::params::service_conf,
  $service_ensure     = $stunnel::params::service_ensure,
  $service_name       = $stunnel::params::service_name,
) inherits stunnel::params {

  validate_hash($global_options)
  validate_hash($tunnels)
  validate_string($package_ensure)
  validate_string($package_name)
  validate_absolute_path($service_conf)

  if is_bool($service_ensure) {
    validate_bool($service_ensure)
  } else {
    validate_string($service_ensure, '^(running|stopped)$')
  }

  validate_string($service_name)

  class {'stunnel::install' :
    package_ensure => $package_ensure,
    package_name   => $package_name
  } ->
  class {'stunnel::config' :
    global_options => $global_options,
    service_conf   => $service_conf,
    tunnels        => $tunnels
  } ~>
  class {'stunnel::service' :
    service_ensure => $service_ensure,
    service_name   => $service_name
  }

  contain('stunnel::install')
  contain('stunnel::config')
  contain('stunnel::service')
}

# vim: ts=2 sw=2
