require 'spec_helper'

describe 'java::jdk::config', :type => :class do 
  
  context 'with no parameters' do
    
    it { should 
      contain_file('/etc/profile.d/jdk.sh').with(
      'ensure' => 'present',
      'owner' => 'root',
      'group' => 'root',
      'mode' => '0655',
    )}
  end
end