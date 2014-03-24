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

  if $ensure_config != absent {
    if empty($template) {
      concat { $config:
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        force   => true,
        warn    => '# This file is managed by Puppet\n#\n',
      }

      concat::fragment { 'openntp_listen':
        ensure  => $ensure_listen,
        target  => $config,
        content => "listen on ${listen}\n",
        order   => 10,
      }

      concat::fragment { 'openntp_server':
        target  => $config,
        content => template('openntp/server.erb'),
        order   => 15,
      }
    } else {
      file { $config:
        ensure  => $ensure_config,
        content => template($template),
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
      }
    }
  }

}
