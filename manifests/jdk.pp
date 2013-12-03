# Class: java::jdk
#
# This module manages installation and configuration of the Java JDK
#
# Parameters:
# jdk_package_name - the name of the jdk package to install
# jdk_package_ensure - the ensure level for the jdk package
# primary_jdk - a yes or no variable of is this is the primary jdk for the system 
# jdk_path - the path that the jdk will install to 
#
# Actions: Installs and configures the Java JDK
#
# Requires: see Modulefile
#
# Sample Usage:
#
class java::jdk (
  $jdk_package_name = $java::params::jdk_package_name,
  $jdk_package_ensure = $java::params::jdk_package_ensure,
  $jdk_path = $java::params::jdk_path,
  $primary_jdk = $java::params::primary_jdk
) inherits java::params {
  
  # validate params
  validate_string($jdk_package_name)
  validate_string($jdk_package_ensure)
  validate_string($primary_jdk)
  
  # validate primary_jdk option is either yes or no
  if ! ($primary_jdk in [ 'yes', 'no' ]) {
    fail('ERROR: primary_jdk must be set to yes or no')
  }
    
  # sub class ordering 
  anchor { 'java::jdk::begin': } ->
  class  { 'java::jdk::install': } ->
  class  { 'java::jdk::config': } -> 
  anchor { 'java::jdk:end': } 
  
}
