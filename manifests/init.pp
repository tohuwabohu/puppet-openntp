# = Class: openntp
#
# Manages the OpenNTP server.
#
# == Parameters
#
# [*ensure*]
#   What state the package should be in. Passed through to package resource.
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#
# [*listen*]
#   Addresses to listen on (ntpd does not listen by default)
#   Examples: nil, *, 127.0.0.1, ::1
#
# [*server*]
#   An array of time servers to be used.
#
# [*template*]
#   The ntpd.conf template.
#
# == Author
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2014 Martin Meinhold, unless otherwise noted.
#
class openntp (
  $ensure = params_lookup('ensure'),
  $disable = params_lookup('disable'),
  $listen = params_lookup('listen'),
  $server = params_lookup('server'),
  $package = params_lookup('package'),
  $config = params_lookup('config'),
  $template = params_lookup('template'),
  $service = params_lookup('service')
) inherits openntp::params {

  $bool_disable = any2bool($disable)
  validate_array($server)
  validate_string($package)
  validate_string($config)
  validate_string($template)
  validate_string($service)

  $ensure_listen = empty($listen) ? {
    true    => absent,
    default => present,
  }
  $manage_service_ensure = $bool_disable ? {
    true    => stopped,
    default => running,
  }
  $manage_service_enable = $bool_disable ? {
    true    => false,
    default => true,
  }

  package { $package: ensure => $ensure }

  if $ensure != absent {
    if empty($template) {
      concat { $config:
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        force   => true,
        warn    => '# This file is managed by Puppet\n#\n',
        require => Package[$package],
        notify  => Service[$service],
      }

      concat::fragment { 'openntp_listen':
        ensure  => $ensure_listen,
        target  => $config,
        content => "listen on ${listen}\n",
        order   => 10,
      }

      concat::fragment { 'openntp_server':
        target  => $config,
        content => template('openntp/server.erb'),
        order   => 15,
      }
    } else {
      file { $config:
        ensure  => present,
        content => template($template),
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
      }
    }

    service { $service:
      ensure  => $manage_service_ensure,
      enable  => $manage_service_enable,
      require => Package[$package],
    }
  }
}
