# = Class: openntp::service
#
# Manage the openntp service.
#
# == Author
#
#   Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2014 Martin Meinhold, unless otherwise noted.
#
class openntp::service inherits openntp {

  $ensure_service = $openntp::enable ? {
    true    => running,
    default => stopped,
  }
  $enable_service = $openntp::enable ? {
    true    => true,
    default => false,
  }

  if $openntp::service_restart == $openntp::params::service_restart {
    # The restart script does not properly check if the service is actually stopped; hence, the start command can fail
    # to start the service because it is still running. This script checks the status and issues the start command as
    # soon as the service is actually stopped.

    $file_ensure = $openntp::ensure ? {
      absent  => absent,
      default => file,
    }

    file { $openntp::params::service_restart:
      ensure  => $file_ensure,
      content => template('openntp/restart.sh.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0555',
      before  => Service[$openntp::service_name]
    }
  }

  if $openntp::ensure != absent {
    service { $openntp::service_name:
      ensure     => $ensure_service,
      enable     => $enable_service,
      hasrestart => true,
      restart    => $openntp::service_restart,
    }
  }

}
