#stunnel

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with stunnel](#setup)
    * [What stunnel affects](#what-stunnel-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with stunnel](#beginning-with-stunnel)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

The stunnel module installs, configures, and manages stunnel.

##Setup

###Setup Requirements

CentOS does not include an init script with their stunnel package. One is not
offered with this module.

###Beginning with stunnel

Instantiate the module with the minimum global configuration and tunnel
configuration to meet your needs.

```puppet
class {'::stunnel' :
  global_options => {
    cert       => '/etc/stunnel/keys/global.pem',
    chroot     => '/var/stunnel4',
    pid        => '/stunnel.pid',
    setuid     => 'stunnel4',
    setgid     => 'stunnel4',
    sslVersion => 'all',
    socket     => [ 'l:TCP_NODELAY=1', 'r:TCP_NODELAY=1'],
    ciphers    => 'HIGH:!AECDH:!ADH:!aNULL:!eNULL:!NULL',
    options    => [
      'DONT_INSERT_EMPTY_FRAGMENTS',
      'NO_SSLv2',
      'NO_SSLv3'
    ],
  },
  tunnels => {
    smtp-tls-tunnel => {
      options => {
        accept  => '2525',
        client  => 'yes',
        connect => 'email-smtp.us-west-2.amazonaws.com:465',
        delay   => 'yes'
      }
    }
  }
}
```

##Usage

All interaction with the stunnel module should be done through the main init class. All other classes are enforced as private.

##Reference

###Classes

####Public Classes

* stunnel: Main class, includes all other classes.

####Private Classes

* stunnel::installs: Handles the package management.
* stunnel::config: Manages the configuration file and chroot directory.
* stunnel::service: Manages the service.
* stunnel::params: Default module parameters

####Types
* stunnel::tunnel: Manages configuration fragments for each service tunnel

###Parameters

The following parameters are available in the `::stunnel` class:

####`global_options`

Global portion of the stunnel configuration. See the stunnel man page and the examples herein for reference.
[https://www.stunnel.org/static/stunnel.html](https://www.stunnel.org/static/stunnel.html)

####`tunnels`

Service tunnel configurations. See the stunnel man page and the examples herein for reference.
[https://www.stunnel.org/static/stunnel.html](https://www.stunnel.org/static/stunnel.html)

####`package_ensure`

Defines state of stunnel package. Valid options are synonymous with the package type `ensure` parameter.
[https://docs.puppetlabs.com/references/latest/type.html#package-attribute-ensure](https://docs.puppetlabs.com/references/latest/type.html#package-attribute-ensure)

####`package_name`
The name of the stunnel package to install. Valid options are synonymous with the package type `name` parameter.
[https://docs.puppetlabs.com/references/latest/type.html#package-attribute-name](https://docs.puppetlabs.com/references/latest/type.html#package-attribute-name)

####`service_conf`
Path to where the stunnel.conf should reside on the filesystem. Must me a valid absolute filesystem path.

####`service_ensure`
The state the stunnel service should be in. Valid options are synonymous with the service type `ensure` parameter.
[https://docs.puppetlabs.com/references/latest/type.html#service-attribute-ensure](https://docs.puppetlabs.com/references/latest/type.html#service-attribute-ensure)

####`service_name`
The name of the stunnel service. Valid options are synonymous with the service type `name` parameter.
[https://docs.puppetlabs.com/references/latest/type.html#service-attribute-name](https://docs.puppetlabs.com/references/latest/type.html#service-attribute-name)

###Sample Hiera Yaml

```yaml
stunnel::global_options:
  cert: '/etc/stunnel/keys/global.pem'
  chroot: '/var/stunnel4'
  pid: '/stunnel.pid' # Relative to chroot
  setuid: 'stunnel4'
  setgid: 'stunnel4'
  sslVersion: 'all'
  socket:
    - 'l:TCP_NODELAY=1'
    - 'r:TCP_NODELAY=1'
  ciphers: 'HIGH:!AECDH:!ADH:!aNULL:!eNULL:!NULL'
  options:
    - 'DONT_INSERT_EMPTY_FRAGMENTS'
    - 'NO_SSLv2'
    - 'NO_SSLv3'
stunnel::tunnels:
  smtp-tls-tunnel:
    options:
      accept: '2525'
      client: 'yes'
      connect: 'email-smtp.us-west-2.amazonaws.com:465'
      delay: 'yes'
  pop3:
    options:
      accept: '127.168.11.10:995'
      connect: '127.0.0.1:110'
```

##Limitations

This module has been tested on:
* Ubuntu 12.04, 14.04
* CentOS 6.0, 7.0

##Development

Submit a pull request, and unit tests for any new functionality.

##Contributors
* focus
