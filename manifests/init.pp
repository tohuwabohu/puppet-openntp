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
#   Set to 'false' to disable service(s) managed by module.
#
# [*listen*]
#   Addresses to listen on (ntpd does not listen by default).
#   Examples: nil, *, 127.0.0.1, ::1
#
# [*server*]
#   An array of time servers to be used.
#   Example: ['ntp.example.org']
#
# [*package_name*]
#   Set the name of the package to be installed.
#
# [*config_file*]
#   Set the path of the configuration file.
#
# [*template*]
#   Set the name of the ntpd.conf template.
#
# [*service_name*]
#   Set the name of the openntpd service.
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
  $ensure       = params_lookup('ensure'),
  $enable       = params_lookup('enable'),
  $listen       = params_lookup('listen'),
  $server       = params_lookup('server'),
  $package_name = params_lookup('package_name'),
  $config_file  = params_lookup('config_file'),
  $template     = params_lookup('template'),
  $service_name = params_lookup('service_name')
) inherits openntp::params {

  validate_string($ensure)
  validate_bool($enable)
  validate_array($server)
  validate_string($package_name)
  validate_absolute_path($config_file)
  validate_string($service_name)

  class { 'openntp::install': } ->
  class { 'openntp::config': } ~>
  class { 'openntp::service': }

}
