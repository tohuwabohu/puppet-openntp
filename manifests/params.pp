# == Class: openntp::params
#
# Default configuration values for the `openntp` class.
#
# === Authors
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2016 Martin Meinhold, unless otherwise noted.
#
class openntp::params {
  $ensure = installed
  $enable = true
  $server = suffix(range('0', '3'), '.debian.pool.ntp.org')
  $package_name = 'openntpd'
  $service_name = 'openntpd'
  $config_file = $facts['os']['family'] ? {
    'FreeBSD' => '/usr/local/etc/ntpd.conf',
    default   => '/etc/openntpd/ntpd.conf'
  }
  $rootuser = 'root'
  $rootgroup = $facts['os']['family'] ? {
    'FreeBSD' => 'wheel',
    default   => 'root'
  }
}
