require 'spec_helper'

describe 'java::jdk::install', :type => :class do
  
  context "with no parameters" do   
    
    let(:facts) { {:jdk_path => '/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.x86_64' } }
    
    it { should 
      contain_package('jdk').with(
      'name' => 'java-1.6.0-openjdk-devel',
      'ensure' => 'present',
    )} 
  end
end