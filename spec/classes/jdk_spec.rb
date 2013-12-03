require 'spec_helper'

describe 'java::jdk', :type => :class do
  
  describe 'with no parameters' do
    
    let(:facts) { {:jdk_path => '/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.x86_64' } }
      
    it { should include_class("java::jdk::install") }
    it { should include_class("java::jdk::config") }
    it { should include_class("java::params") }
  end
  
end