require 'spec_helper'

describe 'openntp' do
  let(:title) { 'openntp' }

  describe 'by default' do
    let(:params) { { } }

    it { should contain_package('openntpd').with_ensure('installed') }
    it { should contain_service('openntpd').with_ensure('running').with_enable(true) }
    it { should contain_file('/etc/openntpd/ntpd.conf').with_ensure('present') }
    it { should contain_file('/etc/openntpd/ntpd.conf').with_content(/server 0.debian.pool.ntp.org/) }
    it { should contain_file('/etc/openntpd/ntpd.conf').with_content(/server 1.debian.pool.ntp.org/) }
    it { should contain_file('/etc/openntpd/ntpd.conf').with_content(/server 2.debian.pool.ntp.org/) }
    it { should contain_file('/etc/openntpd/ntpd.conf').with_content(/server 3.debian.pool.ntp.org/) }
  end

  describe 'with custom version' do
    let(:params) { {:ensure => '1.0.0'} }

    it { should contain_package('openntpd').with_ensure('1.0.0') }
  end

  describe 'with ensure absent' do
    let(:params) { {:ensure => 'absent'} }

    it { should contain_package('openntpd').with_ensure('absent') }
    it { should_not contain_file('/etc/openntpd/ntpd.conf') }
    it { should_not contain_service('openntpd') }
  end

  describe 'with custom server' do
    let(:params) { {:server => ['ntp.example.org']} }

    it { should contain_file('/etc/openntpd/ntpd.conf').with_content(/server ntp.example.org/) }
    it { should_not contain_file('/etc/openntpd/ntpd.conf').with_content(/server 0.debian.pool.ntp.org/) }
  end

  describe 'disable service' do
    let(:params) { {:disable => true } }

    it { should contain_file('/etc/openntpd/ntpd.conf').with_ensure('present') }
    it { should contain_package('openntpd').with_ensure('installed') }
    it { should contain_service('openntpd').with_ensure('stopped').with_enable(false) }
  end
end
