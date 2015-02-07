# = Class: openntp::install
#
# Install the openntp package.
#
# == Author
#
#   Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2014 Martin Meinhold, unless otherwise noted.
#
class openntp::install inherits openntp {

  if $openntp::ensure != absent and $::lsbdistid == 'Ubuntu' {
    # Installing openntpd will automatically remove the ntp package. But on Ubuntu, just removing the package will leave
    # the apparmor profile behind. This still active apparmor profile will then prevent the openntpd service from
    # accessing its own configuration file. The solution is to purge the package (to get rid of the apparmor profile)
    # and then reload the apparmor service to pickup the configuration change.
    #
    # see https://bugs.launchpad.net/ubuntu/+source/openntpd/+bug/458061 for more information

    package { 'ntp':
      ensure => purged,
      before => Package[$openntp::package_name],
    }

    exec { 'reload apparmor service after ntp removal':
      command     => 'service apparmor reload',
      path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
      refreshonly => true,
      subscribe   => Package['ntp'],
      before      => Package[$openntp::package_name],
    }
  }

  package { $openntp::package_name:
    ensure => $openntp::ensure,
  }

}
