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

  if $openntp::ensure != absent {
    service { $openntp::service:
      ensure  => $ensure_service,
      enable  => $enable_service,
    }
  }

}
