require 'spec_helper'

describe 'java::jdk', :type => :define do 
  
  ## test for jdk version 6 on Debian based systems ##
  context 'on debian systems with jdk 6' do
    
    let :title do
      'debian-jdk6'
    end
    
    let(:facts) {{ :osfamily => 'Debian' }}
      
    it do
      should contain_package('jdk').with({
      'name'   => 'openjdk-6-jdk',
      'ensure' => 'present',
      })
    end
      
    it do 
      should contain_file('jdk.sh').with({
      'path'   => '/etc/profile.d/jdk.sh',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0655',
      'ensure' => 'present',
      })
    end  
  end
  
  ## test for jdk version 7 on Debian based systems ##
  context 'on debian systems with jdk 7' do
    
    let :title do
      'debian-jdk7'
    end
    
    let(:facts) {{ :osfamily => 'Debian' }}
      
    let :params do
      {
        :openjdk_version => 7,
      }
    end
      
    it do
      should contain_package('jdk').with({
      'name'   => 'openjdk-7-jdk',
      'ensure' => 'present',
      })
    end
      
    it do 
      should contain_file('jdk.sh').with({
      'path'   => '/etc/profile.d/jdk.sh',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0655',
      'ensure' => 'present',
      })
    end  
  end
  
  ## test for jdk version 6 on RedHet based systems ##
  context 'on redhat systems with jdk 6' do
    
    let :title do
      'rhel-jdk6'
    end
    
    let(:facts) {{ :osfamily => 'RedHat' }}

    it do
      should contain_package('jdk').with({
      'name'   => 'java-1.6.0-openjdk-devel',
      'ensure' => 'present',
      })
    end
      
    it do 
      should contain_file('jdk.sh').with({
      'path'   => '/etc/profile.d/jdk.sh',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0655',
      'ensure' => 'present',
      })
    end 
  end
  
  ## test for jdk version 7 on RedHat based systems ##
  context 'on redhat systems with jdk 7' do
    
    let :title do
      'rhel-jdk7'
    end
    
    let(:facts) {{ :osfamily => 'RedHat' }}
      
    let :params do
      {
        :openjdk_version => 7,
      }
    end
      
    it do
      should contain_package('jdk').with({
      'name'   => 'java-1.7.0-openjdk-devel',
      'ensure' => 'present',
      })
    end
      
    it do 
      should contain_file('jdk.sh').with({
      'path'   => '/etc/profile.d/jdk.sh',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0655',
      'ensure' => 'present',
      })
    end   
  end
  
  ## test for custom jdk on either system ##
  context 'Custom jdk' do 
    
    let :title do
      'custom-jdk'
    end
    
    let :params do
      {
       :jdkpackage => 'customjdk',
       :jdkpath    => '/usr/java', 
      }
    end
    
    it do
      should contain_package('jdk').with({
       'name'   => 'customjdk',
       'ensure' => 'present', 
      })
    end
    
    it do 
      should contain_file('jdk.sh').with({
      'path'   => '/etc/profile.d/jdk.sh',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0655',
      'ensure' => 'present',
      })
    end
  end
  
end