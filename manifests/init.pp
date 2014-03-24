# = Class: openntp
#
# Manages the OpenNTP server.
#
# == Parameters
#
# [*ensure*]
#   What state the package should be in. Passed through to package resource.
#
# [*enable*]
#   Set to 'false' to disable service(s) managed by module
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
  $enable = params_lookup('enable'),
  $listen = params_lookup('listen'),
  $server = params_lookup('server'),
  $package_name = params_lookup('package_name'),
  $config = params_lookup('config'),
  $template = params_lookup('template'),
  $service = params_lookup('service')
) inherits openntp::params {

  validate_string($ensure)
  validate_bool($enable)
  validate_array($server)
  validate_string($package_name)
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

  class { 'openntp::install': } ->
  class { 'openntp::config': } ~>
  class { 'openntp::service': }

}
