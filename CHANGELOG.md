##2015-02-07 - Release 2.0.0
###Summary

* Add module_data to replace params class and make os-specific configuration easier (requires Puppet 3.x)
* Add `options_hash` to use custom data in combination with a custom `template`
* Add custom restart script to ensure to service is really running after a restart (can be turned off)
* Add support for Ubuntu 12.04 and 14.04
* Add acceptance tests to make sure everything works in practice
