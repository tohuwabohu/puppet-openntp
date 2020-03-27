# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Next

### Changed

- Update Ruby Gems

### Removed 

- `service_restart` parameter  

## 2016-06-13 - Release 2.3.0
###Summary

Add support for FreeBSD ([#6](https://github.com/tohuwabohu/puppet-openntp/pull/6).

##2016-03-25 - Release 2.1.0
###Summary

This release improves compatibility with Puppet 4.

####Improvements

Replace [ripienaar/module_data](https://forge.puppetlabs.com/ripienaar/module_data) with `params.pp`; the module is
unlikly to work with Puppet 4 (see [Native Puppet 4 Data in Modules](https://www.devco.net/archives/2016/01/08/native-puppet-4-data-in-modules.php))
and in order to not break Puppet 3 support it is easier to just stick with a simple `params.pp` for the moment.

Furthermore, the test infrastructure has been overhauled:

* Bump gem dependencies to the latest version
* Bump Puppet module dependencies to the latest version
* Update travis test matrix and add support for Puppet 4

##2016-01-11 - Release 2.0.2
###Summary

Apparmor reload will only happen if parser exists ([#1](https://github.com/tohuwabohu/puppet-openntp/pull/1) and
[#2](https://github.com/tohuwabohu/puppet-openntp/pull/2)).

Furthermore, the test infrastructure has been updated

* Update all gems to the latest version
* Update all Beaker acceptance tests to use Docker instead of Virtualbox
* Remove Ruby 1.8.7 from test matrix

##2015-02-08 - Release 2.0.1
###Summary

* Ensure generated configuration file is consistent with previous version

##2015-02-07 - Release 2.0.0
###Summary

* Add module_data to replace params class and make os-specific configuration easier (requires Puppet 3.x)
* Add `options_hash` to use custom data in combination with a custom `template`
* Add custom restart script to ensure to service is really running after a restart (can be turned off)
* Add support for Ubuntu 12.04 and 14.04
* Add acceptance tests to make sure everything works in practice
