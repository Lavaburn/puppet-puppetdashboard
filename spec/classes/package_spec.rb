require 'spec_helper'
describe 'puppetdashboard::install::package', :type => :class do
  context "on a Debian OS" do
    let :facts do
      {
        :osfamily        => 'Debian',
        :operatingsystem => 'Debian',
      }
    end
    describe "with no parameters" do
      it { should contain_class('puppetdashboard::params') }
      it { should contain_package('puppet-dashboard').with(
        'ensure'  => 'installed',
        'name'    => 'puppet-dashboard'
      ) }
      it { should contain_file('dashboard_install_dir').with(
        'ensure'  => 'directory',
        'path'    => '/usr/share/puppet-dashboard'
      ) }
      it { should contain_file('/etc/puppet-dashboard').with(
        'ensure'  => 'directory'
      ) }
    end
    describe 'when ensure is absent' do
      let :params do
        {
          :ensure => 'absent'
        }
      end
      it { should contain_package('puppet-dashboard').with(
        'ensure'  => 'absent'
      ) }
    end
  end
end