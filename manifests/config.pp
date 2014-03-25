# = Class: openntp::config
#
# Configure the openntp installation.
#
# == Author
#
#   Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2014 Martin Meinhold, unless otherwise noted.
#
class openntp::config inherits openntp {

  $ensure_listen = empty($openntp::listen) ? {
    true    => absent,
    default => present,
  }
  $ensure_config = $openntp::ensure ? {
    absent  => absent,
    default => present,
  }

  if $ensure_config != absent {
    if empty($openntp::template) {
      concat { $openntp::config_file:
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        force   => true,
        warn    => '# This file is managed by Puppet',
      }

      concat::fragment { 'openntp_listen':
        ensure  => $ensure_listen,
        target  => $openntp::config_file,
        content => "listen on ${openntp::listen}\n",
        order   => 10,
      }

      concat::fragment { 'openntp_server':
        target  => $openntp::config_file,
        content => template('openntp/server.erb'),
        order   => 15,
      }
    } else {
      file { $openntp::config_file:
        ensure  => $ensure_config,
        content => template($openntp::template),
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
      }
    }
  }

}
