require 'spec_helper'

describe 'java::jre::cacert', :type => :define do 
  
  ## cacert for jre 6 on Debian systems ##
  context 'on debian system with jre 6' do
  
    let :title do
      'puppet:///files/cacerts/cacert'
    end
    
    let(:facts) {{ :osfamily => 'Debian' }}
    
    it do
      should contain_file('/usr/lib/jvm/java-1.6.0-openjdk/jre/lib/security/cacerts').with({
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0644',
      'ensure' => 'present',
      })
    end
  end
  
  ## cacert for jre 7 on Debian systems ##
  context 'on debian system with jre 7' do
  
    let :title do
      'puppet:///files/cacerts/cacert'
    end
    
    let :params do
      {
        :openjre_version => 7,
      }
    end
    
    let(:facts) {{ :osfamily => 'Debian' }}
    
    it do
      should contain_file('/usr/lib/jvm/java-1.7.0-openjdk/jre/lib/security/cacerts').with({
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0644',
      'ensure' => 'present',
      })
    end
  end
  
  ## cacert for jre 6 on RedHat systems ##
  context 'on redhat system with jre 6' do
  
    let :title do
      'puppet:///files/cacerts/cacert'
    end
    
    let(:facts) {{ :osfamily => 'RedHat' }}
    
    it do
      should contain_file('/usr/lib/jvm/jre-1.6.0/jre/lib/security/cacerts').with({
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0644',
      'ensure' => 'present',
      })
    end
  end
  
  ## cacert for jre 7 on RedHat systems ##
  context 'on redhat system with jre 7' do
  
    let :title do
      'puppet:///files/cacerts/cacert'
    end
    
    let :params do
      {
        :openjre_version => 7,
      }
    end
    
    let(:facts) {{ :osfamily => 'RedHat' }}
    
    it do
      should contain_file('/usr/lib/jvm/jre-1.7.0/jre/lib/security/cacerts').with({
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0644',
      'ensure' => 'present',
      })
    end
  end
  
  ## cacert for custom jre package ##
  context 'with test params' do
    
    let :title do 
      'puppet:///files/cacerts/cacert'
    end
    
    let :params do
      {
        :owner   => 'testuser',
        :group   => 'testuser',
        :mode    => '0655',
        :jrepath => '/usr/lib/java',
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