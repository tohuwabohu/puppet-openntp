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
  $service_restart = '/usr/local/sbin/restart-openntpd'
  $config_file = '/etc/openntpd/ntpd.conf'
}
