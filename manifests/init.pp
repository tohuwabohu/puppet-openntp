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
  $ensure_config = $ensure ? {
    absent  => absent,
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

  class { 'openntp::install': } ->
  class { 'openntp::config': }

  if $ensure != absent {
    service { $service:
      ensure  => $manage_service_ensure,
      enable  => $manage_service_enable,
      require => Package[$package],
    }
  }
}
