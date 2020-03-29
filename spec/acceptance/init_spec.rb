require 'spec_helper_acceptance'

describe 'by default' do
  specify 'should provision with no errors' do
    apply_manifest("class { 'openntp': }", :catch_failures => true)
  end

  specify 'should be idempotent' do
    apply_manifest("class { 'openntp': }", :catch_changes => true)
  end

  describe package('openntpd') do
    specify { should be_installed }
  end

  describe file('/etc/openntpd/ntpd.conf') do
    specify { should be_file }
  end

  # Detecting the current process status is broken due to:  Failed to connect to bus: No such file or directory
  describe service('openntpd'), :unless => fact('os.name') == 'Ubuntu' && fact('os.release.full') == '16.04' do
    specify { should be_enabled }
    specify { should be_running }
  end
end
