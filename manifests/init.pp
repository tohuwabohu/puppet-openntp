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
# [*service_name*]
#   Set the name of the openntpd service.
#
# [*service_restart*]
#   Set the command used to restart the service. If set to `undef`, the Puppet default will be used. Otherwise the
#   referenced command is used. Used to provide a custom restart command that ensures the service is properly restarted.
#
# [*config_file*]
#   Set the path of the configuration file.
#
# [*template*]
#   Set to the name of an alternative template file (if you don't want to use the default one).
#
# [*options_hash*]
#   Used in combination with a custom `template` to provide custom data.
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
  $ensure          = $openntp::params::ensure,
  $enable          = $openntp::params::enable,
  $listen          = undef,
  $server          = $openntp::params::server,
  $package_name    = $openntp::params::package_name,
  $service_name    = $openntp::params::service_name,
  $service_restart = $openntp::params::service_restart,
  $config_file     = $openntp::params::config_file,
  $template        = undef,
  $options_hash    = { },
) inherits openntp::params {

  validate_string($ensure)
  validate_bool($enable)
  validate_array($server)
  validate_string($package_name)
  validate_absolute_path($config_file)
  validate_string($service_name)
  validate_hash($options_hash)

  class { 'openntp::install': } ->
  class { 'openntp::config': } ~>
  class { 'openntp::service': }

}
