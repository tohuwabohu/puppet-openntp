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

  $ensure_config = $openntp::ensure ? {
    'absent' => absent,
    default  => file,
  }

  $real_template = empty($openntp::template) ? {
    true    => 'openntp/ntpd.conf.erb',
    default => $openntp::template,
  }

  file { $openntp::config_file:
    ensure  => $ensure_config,
    content => template($real_template),
    owner   => $openntp::rootuser,
    group   => $openntp::rootgroup,
    mode    => '0644',
  }
}
