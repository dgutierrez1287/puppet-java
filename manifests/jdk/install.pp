# PRIVATE CLASS: do not call directly
# Class java::jdk::install
#
# This class installs the jdk that is specified
#
class java::jdk::install {
  
  # params -> variables 
  $package_name = $java::jdk::jdk_package_name
  $package_ensure = $java::jdk::jdk_package_ensure
  
  # install a jdk package
  package { 'jdk':
    name => $package_name,
    ensure => $package_ensure,
  }
} 