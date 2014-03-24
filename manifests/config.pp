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

  if $openntp::ensure_config != absent {
    if empty($openntp::template) {
      concat { $openntp::config_name:
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        force   => true,
        warn    => '# This file is managed by Puppet\n#\n',
      }

      concat::fragment { 'openntp_listen':
        ensure  => $openntp::ensure_listen,
        target  => $openntp::config_name,
        content => "listen on ${openntp::listen}\n",
        order   => 10,
      }

      concat::fragment { 'openntp_server':
        target  => $openntp::config_name,
        content => template('openntp/server.erb'),
        order   => 15,
      }
    } else {
      file { $openntp::config_name:
        ensure  => $openntp::ensure_config,
        content => template($openntp::template),
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
      }
    }
  }

}
