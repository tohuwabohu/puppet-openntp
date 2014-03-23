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
  $disable = false

  $listen = undef
  $server = ['0.debian.pool.ntp.org', '1.debian.pool.ntp.org', '2.debian.pool.ntp.org', '3.debian.pool.ntp.org']

  $package = $::operatingsystem ? {
    default => 'openntpd'
  }
  $config = $::operatingsystem ? {
    default => '/etc/openntpd/ntpd.conf'
  }
  $template = undef
  $service = $::operatingsystem ? {
    default => 'openntpd'
  }
}
