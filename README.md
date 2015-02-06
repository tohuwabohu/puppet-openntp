#openntp

##Overview

This module installs and manages OpenNTPD.

##Usage

* Just use the default installation
```
class { 'openntp': }
```

* Specify a list of time servers to use
```
class { 'openntp': server => ['ntp.example.org'] }
```

##Limitations

The module has been tested on the following operating systems. Testing and patches for other platforms are welcome.

* Debian Linux 6.0 (Squeeze)
* Debian Linux 7.0 (Wheezy)

[![Build Status](https://travis-ci.org/tohuwabohu/puppet-openntp.png?branch=master)](https://travis-ci.org/tohuwabohu/puppet-openntp)

##Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
