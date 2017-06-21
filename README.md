# openntp

[![Puppet Forge](https://img.shields.io/puppetforge/v/tohuwabohu/openntp.svg)](https://forge.puppetlabs.com/tohuwabohu/openntp)
[![Build Status](https://travis-ci.org/tohuwabohu/puppet-openntp.png?branch=master)](https://travis-ci.org/tohuwabohu/puppet-openntp)

## Overview

This module installs and manages OpenNTPD.

## Usage

* Just use the default installation
```
class { 'openntp': }
```

* Specify a list of time servers to use
```
class { 'openntp': server => ['ntp.example.org'] }
```

## Limitations

The module has been tested on the following operating systems. Testing and patches for other platforms are welcome.

* Debian 7.0 (Wheezy)
* Debian 8.0 (Jessie)
* Ubuntu 12.04 (Precise Pangolin)
* Ubuntu 14.04 (Trusty Tahr)
* FreeBSD 10

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### Development

This project uses rspec-puppet and beaker to ensure the module works as expected and to prevent regressions.

```
gem install bundler
bundle install --path vendor

bundle exec rake spec
bundle exec rake beaker
```
(note: see [Beaker - Supported ENV variables](https://github.com/puppetlabs/beaker-rspec/blob/master/README.md)
for a list of environment variables to control the default behaviour of Beaker)
