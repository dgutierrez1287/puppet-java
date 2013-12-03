require 'spec_helper'

describe 'java::jdk::cacert', :type => :define do 
  
  context 'with default params' do
  
    let :title do
      'puppet:///files/cacerts/cacert'
    end
    
    let :params do
      {
        :jdkpath => '/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.x86_64/',
      }
    end
    
    it do
      should contain_file('/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.x86_64/jre/lib/security/cacerts').with({
      'owner' => 'root',
      'group' => 'root',
      'mode' => '0644',
      'ensure' => 'present',
      })
    end
  end 
  
  context 'with test params' do
    
    let :title do 
      'puppet:///files/cacerts/cacert'
    end
    
    let :params do
      {
        :owner => 'testuser',
        :group => 'testuser',
        :mode => '0655',
        :jdkpath => '/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.x86_64/',
      }
    end
      
    it do
      should contain_file('/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.x86_64/jre/lib/security/cacerts').with({
      'owner' => 'testuser',
      'group' => 'testuser',
      'mode' => '0655',
      'ensure' => 'present',
    })
    
    end
  end
end