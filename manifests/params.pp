# Class java::params
# 
# This class contains the default params 
# for the java class
# 
class java::params {
  $jdk_package_name = 'java-1.6.0-openjdk-devel'
  $jdk_package_ensure = 'present'
  $jdk_path = '/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.x86_64'
  $primary_jdk = 'yes' 
}