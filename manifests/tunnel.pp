# Define: stunnel::tunnel
#

define stunnel::tunnel ($options) {

  assert_private()

  validate_hash($options)

  concat::fragment { $name :
    target  => $stunnel::service_conf,
    content => template('stunnel/stunnel.conf.tunnel.erb')
  }
}

# vim: ts=2 sw=2
