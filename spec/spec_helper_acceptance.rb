require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

unless ENV['BEAKER_PROVISION'] == 'no'
  hosts.each do |host|
    if host['platform'] =~ /debian-6-amd64/
      on host, 'echo "deb http://ftp.de.debian.org/debian-backports/ squeeze-backports main" > /etc/apt/sources.list.d/backports.list'
      install_puppet # workaround for broken vagrant images, see yml file
    end
  end
end

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  ignore_list = %w(junit log spec tests vendor)

  c.formatter = :documentation

  c.before :suite do
    hosts.each do |host|
      # Install module
      copy_module_to(host, :source => proj_root, :module_name => 'openntp', :ignore_list => ignore_list)

      # Install dependencies
      on host, puppet('module', 'install', 'ripienaar-module_data', '--version 0.0.3')
      on host, puppet('module', 'install', 'puppetlabs-stdlib', '--version 4.3.2')
    end
  end
end
