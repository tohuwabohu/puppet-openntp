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

  if $openntp::ensure != absent {
    service { $openntp::service:
      ensure  => $openntp::manage_service_ensure,
      enable  => $openntp::manage_service_enable,
    }
  }

}
