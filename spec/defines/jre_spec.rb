require 'spec_helper'

describe 'java::jre', :type => :define do
  
  ## test for jre version 6 on Debian based systems ##
  context 'on debian systems with jre 6' do
    
    let :title do
      'debian-jre6'
    end
    
    let(:facts) {{ :osfamily => 'Debian' }}
      
    it do
      should contain_package('jre').with({
      'name'   => 'openjdk-6-jre',
      'ensure' => 'present',
      })
    end
      
    it do 
      should contain_file('jre.sh').with({
      'path'   => '/etc/profile.d/jre.sh',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0655',
      'ensure' => 'present',
      })
    end  
  end
  
  ## test for jre version 7 on Debian based systems ##
  context 'on debian systems with jre 7' do
    
    let :title do
      'debian-jre6'
    end
    
    let(:facts) {{ :osfamily => 'Debian' }}
      
    let :params do
      {
        :openjre_version => 7,
      }
    end
      
    it do
      should contain_package('jre').with({
      'name'   => 'openjdk-7-jre',
      'ensure' => 'present',
      })
    end
      
    it do 
      should contain_file('jre.sh').with({
      'path'   => '/etc/profile.d/jre.sh',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0655',
      'ensure' => 'present',
      })
    end  
  end
  
  ## test for jre version 6 on RedHet based systems ##
  context 'on redhat systems with jre 6' do
    
    let :title do
      'rhel-jre6'
    end
    
    let(:facts) {{ :osfamily => 'RedHat' }}

    it do
      should contain_package('jre').with({
      'name'   => 'java-1.6.0-openjdk',
      'ensure' => 'present',
      })
    end
      
    it do 
      should contain_file('jre.sh').with({
      'path'   => '/etc/profile.d/jre.sh',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0655',
      'ensure' => 'present',
      })
    end 
  end
  
  ## test for jre version 7 on RedHet based systems ##
  context 'on redhat systems with jre 7' do
    
    let :title do
      'rhel-jre7'
    end
    
    let :params do
      {
        :openjre_version => 7,
      }
    end
    
    let(:facts) {{ :osfamily => 'RedHat' }}

    it do
      should contain_package('jre').with({
      'name'   => 'java-1.7.0-openjdk',
      'ensure' => 'present',
      })
    end
      
    it do 
      should contain_file('jre.sh').with({
      'path'   => '/etc/profile.d/jre.sh',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0655',
      'ensure' => 'present',
      })
    end 
  end
  
  ## test for custom jre on either system ##
  context 'Custom jre' do 
    
    let :title do
      'custom-jre'
    end
    
    let :params do
      {
       :jrepackage => 'customjre',
       :jrepath    => '/usr/java', 
      }
    end
    
    it do
      should contain_package('jre').with({
       'name'   => 'customjre',
       'ensure' => 'present', 
      })
    end
    
    it do 
      should contain_file('jre.sh').with({
      'path'   => '/etc/profile.d/jre.sh',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0655',
      'ensure' => 'present',
      })
    end
  end
  
end