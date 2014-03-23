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
  $server = params_lookup('server'),
  $template = params_lookup('template')
) inherits openntp::params {

  $bool_disable = any2bool($disable)
  validate_array($server)
  validate_string($template)

  $manage_service_ensure = $openntp::bool_disable ? {
    true    => 'stopped',
    default => 'running',
  }

  $manage_service_enable = $openntp::bool_disable ? {
    true    => false,
    default => true,
  }

  package { 'openntpd': ensure => $ensure }

  if $ensure != absent {
    file { '/etc/openntpd/ntpd.conf':
      ensure  => 'present',
      content => template($openntp::template),
      owner   => root,
      group   => root,
      mode    => '0644',
      require => Package['openntpd'],
      notify  => Service['openntpd'],
    }

    service { 'openntpd':
      ensure  => $manage_service_ensure,
      enable  => $manage_service_enable,
      require => Package['openntpd'],
    }
  }
}
