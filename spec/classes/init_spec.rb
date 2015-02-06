require 'spec_helper'

describe 'openntp' do
  let(:title) { 'openntp' }
  let(:facts) { {:concat_basedir => '/path/to/dir'} }
  let(:config_file) { '/etc/openntpd/ntpd.conf' }

  describe 'by default' do
    let(:params) { { } }

    it { should contain_package('openntpd').with_ensure('installed') }
    it { should contain_service('openntpd').with_ensure('running').with_enable(true) }
    it { should contain_file(config_file) }
    it { should contain_file(config_file).with_ensure('file') }
    it { should contain_file(config_file).without_content(/listen on/) }
    it { should contain_file(config_file).with_content(/server 0.debian.pool.ntp.org/) }
    it { should contain_file(config_file).with_content(/server 1.debian.pool.ntp.org/) }
    it { should contain_file(config_file).with_content(/server 2.debian.pool.ntp.org/) }
    it { should contain_file(config_file).with_content(/server 3.debian.pool.ntp.org/) }
  end

  describe 'with custom version' do
    let(:params) { {:ensure => '1.0.0'} }

    it { should contain_package('openntpd').with_ensure('1.0.0') }
  end

  describe 'with ensure absent' do
    let(:params) { {:ensure => 'absent'} }

    it { should contain_package('openntpd').with_ensure('absent') }
    it { should contain_file(config_file).with_ensure('absent') }
    it { should_not contain_service('openntpd') }
  end

  describe 'with listen on any interface' do
    let(:params) { {:listen => '*'} }

    it { should contain_file(config_file).with_content(/listen on */) }
  end

  describe 'with listen on localhost only' do
    let(:params) { {:listen => '127.0.0.1'} }

    it { should contain_file(config_file).with_content(/listen on 127.0.0.1/) }
  end

  describe 'with listen disabled' do
    let(:params) { {:listen => ''} }

    it { should contain_file(config_file).without_content('listen on') }
  end

  describe 'with custom server' do
    let(:params) { {:server => ['ntp.example.org']} }

    it { should contain_file(config_file).with_content(/server ntp.example.org/) }
    it { should contain_file(config_file).without_content(/server 0.debian.pool.ntp.org/) }
  end

  describe 'with custom template file' do
    let(:params) { {:template => 'openntp/server.erb'} }

    it { should contain_file('/etc/openntpd/ntpd.conf') }
  end

  describe 'disable service' do
    let(:params) { {:enable => false} }

    it { should contain_file(config_file) }
    it { should contain_package('openntpd').with_ensure('installed') }
    it { should contain_service('openntpd').with_ensure('stopped').with_enable(false) }
  end
end
