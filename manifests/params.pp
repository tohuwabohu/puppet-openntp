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
  $service_restart = $osfamily ? {
    'Debian' => '/usr/local/sbin/restart-openntpd',
    default =>  undef
  }
  $config_file = $osfamily ? {
    'FreeBSD' => '/usr/local/etc/ntpd.conf',
    default   => '/etc/openntpd/ntpd.conf'
  }
  $rootuser = 'root'
  $rootgroup = $osfamily ? {
    'FreeBSD' => 'wheel',
    default   => 'root'
  }
}
