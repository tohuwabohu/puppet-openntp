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

  package { $openntp::package:
    ensure => $openntp::ensure,
  }

}
