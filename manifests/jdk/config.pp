# PRIVATE CLASS: do not call directly
# Class java::config
#
# this class handles any configuration that is needed
# for the java package
#
class java::jdk::config {
 
 # params -> variables
  $primary_jdk = $java::jdk::primary_jdk
  
  # if the jdk being installed is the primary one 
  if $primary_jdk == 'yes' {
        
    # place the profile.d script for the jdk 
    file { 'jdk.sh':
      ensure  => 'present',
      path    => '/etc/profile.d/jdk.sh',
      content => template('java/jdk.sh.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => 0655,
    }
  }
}