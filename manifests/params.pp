# = Class: openntp::params
#
# Defines default values for the openntp class.
#
# == Author
#
#   Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2014 Martin Meinhold, unless otherwise noted.
#
class openntp::params {
  $ensure = installed
  $enable = true

  $listen = undef
  $server = ['0.debian.pool.ntp.org', '1.debian.pool.ntp.org', '2.debian.pool.ntp.org', '3.debian.pool.ntp.org']

  $package_name = $::operatingsystem ? {
    default => 'openntpd'
  }
  $config_name = $::operatingsystem ? {
    default => '/etc/openntpd/ntpd.conf'
  }
  $template = undef
  $service_name = $::operatingsystem ? {
    default => 'openntpd'
  }
}
