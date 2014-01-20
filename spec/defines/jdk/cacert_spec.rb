require 'spec_helper'

describe 'java::jdk::cacert', :type => :define do 
  
  ## cacert for jdk 6 on Debian systems ##
  context 'on debian system with jdk 6' do
  
    let :title do
      'puppet:///files/cacerts/cacert'
    end
    
    let(:facts) {{ :osfamily => 'Debian', :architecture => 'x86_64' }}
    
    it do
      should contain_file('/usr/lib/jvm/java-1.6.0-openjdk-x86_64/jre/lib/security/cacerts').with({
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0644',
      'ensure' => 'present',
      })
    end
  end
  
  ## cacert for jdk 7 on Debian systems ##
  context 'on debian system with jdk 7' do
  
    let :title do
      'puppet:///files/cacerts/cacert'
    end
    
    let :params do
      {
        :openjdk_version => 7,
      }
    end
    
    let(:facts) {{ :osfamily => 'Debian', :architecture => 'x86_64' }}
    
    it do
      should contain_file('/usr/lib/jvm/java-1.7.0-openjdk-x86_64/jre/lib/security/cacerts').with({
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0644',
      'ensure' => 'present',
      })
    end
  end
  
  ## cacert for jdk 6 on RedHat systems ##
  context 'on redhat system with jdk 6' do
  
    let :title do
      'puppet:///files/cacerts/cacert'
    end
    
    let(:facts) {{ :osfamily => 'RedHat', :architecture => 'x86_64' }}
    
    it do
      should contain_file('/usr/lib/jvm/java-1.6.0-openjdk.x86_64/jre/lib/security/cacerts').with({
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0644',
      'ensure' => 'present',
      })
    end
  end
  
  ## cacert for jdk 7 on RedHat systems ##
  context 'on redhat system with jdk 7' do
  
    let :title do
      'puppet:///files/cacerts/cacert'
    end
    
    let :params do
      {
        :openjdk_version => 7,
      }
    end
    
    let(:facts) {{ :osfamily => 'RedHat', :architecture => 'x86_64' }}
    
    it do
      should contain_file('/usr/lib/jvm/java-1.7.0-openjdk.x86_64/jre/lib/security/cacerts').with({
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0644',
      'ensure' => 'present',
      })
    end
  end
  
  ## cacert for custom jdk on any OS ##
  context 'with test params' do
    
    let :title do 
      'puppet:///files/cacerts/cacert'
    end
    
    let :params do
      {
        :owner   => 'testuser',
        :group   => 'testuser',
        :mode    => '0655',
        :jdkpath => '/usr/lib/java',
      }
    end
      
    it do
      should contain_file('/usr/lib/java/jre/lib/security/cacerts').with({
      'owner'  => 'testuser',
      'group'  => 'testuser',
      'mode'   => '0655',
      'ensure' => 'present',
    })
    
    end
  end
end