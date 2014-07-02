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
  $ensure       = $openntp::params::ensure,
  $enable       = $openntp::params::enable,
  $listen       = $openntp::params::listen,
  $server       = $openntp::params::server,
  $package_name = $openntp::params::package_name,
  $config_file  = $openntp::params::config_file,
  $template     = $openntp::params::template,
  $service_name = $openntp::params::service_name
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
