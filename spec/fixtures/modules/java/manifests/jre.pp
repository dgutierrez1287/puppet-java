# define java::jre
#
# This define will install the jre and set up a profile script 
# if the jre is set to be the primary jre, this will install a 
# an openjdk-jre by default (a version of the openjdk) can be specified 
# or it will install a custom jre package that can be specified.
#
# Parameters:
# name(title) - This parameter serves no purpose other then being required by puppet
# jrepackage - A custom jre package to be installed 
# jreensure - The ensure for the custom or openjdk-jre package, this must be present or absent for openjdk-jre but can be a version for a custom jre
# jrepath - the path where the jre is installed too, this is only mandatory if its a custom jre package otherwise this is already prefilled 
# openjre_version - the version of the openjdk-jre to install, currently only version 6 and 7 are supported
# primary_jre - this must be either yes or no, this will set the JDK_HOME and JAVA_HOME in the profile script if it is set to yes
#
define java::jre (
  $jrename = $title,
  $jrepackage = '',
  $jreensure = 'present',
  $jrepath = '',
  $openjre_version = 6,
  $primary_jre = 'yes',
) {
  
  # validate params
  validate_string($jrepackage)
  validate_string($jreensure)
  validate_string($primary_jre)
  
  # fail if the primary_jre is not set to yes or no
  if ! ($primary_jre in [ 'yes', 'no' ]) {
    fail ('ERROR: primary_jdk must be set to yes or no')
  }   
  
  # validate params based on package_name
  # if there is no package_name given the install the openjdk-jre
  if $jrepackage == '' {
    
    # fail if there is a supplied ensure that is not present or absent
    if ! ($jreensure in [ 'present', 'absent' ]) {
      fail('ensure is not valid for using openjdk-jre, must be present or absent')
    }   
    
    # fail if the jre_version is not a number
    if ! is_integer($openjre_version) {
      fail('ERROR: jre_version must be a number')
    }
    
    # set path based on jre_version and osfamily
    # if the jre version is 6
    if $openjre_version == 6 {
      
      # set jre_path based on osfamily
      case $osfamily {
        # if the osfamily is redhat 
        'RedHat': {
          $openjre_path = "/usr/lib/jvm/jre-1.6.0"
          
          package { 'jre':
            name   => 'java-1.6.0-openjdk',
            ensure => $jreensure,
          }
        }
        # if the osfamily is debian
        'Debian': {
          $openjre_path = "/usr/lib/jvm/java-1.6.0-openjdk"
          
          package { 'jre':
            name   => 'openjdk-6-jre',
            ensure => $jreensure,
          }
        }
        # else fail the OS is not supported
        default: {
          fail('Sorry this is not a supported operating system')
        }
      }
    }
    # if the jre version is 7
    elsif $openjre_version == 7 {
      # set path based on osfamily
      case $osfamily {
        # if the osfamily is redhat 
        'RedHat': {
          $openjre_path = "/usr/lib/jvm/jre-1.7.0"
          
          package { 'jre':
            name   => 'java-1.7.0-openjdk',
            ensure => $jreensure,
          }
        }
        # if the osfamily is debian
        'Debian': {
          $openjre_path = "/usr/lib/jvm/java-1.7.0-openjdk"
          
          package { 'jre':
            name   => 'openjdk-7-jre',
            ensure => $jreensure,
          }
        }
        # else fail the OS is not supported
        default: {
          fail('Sorry this is not a supported operating system')
        }
      }
    }
    # else fail since the jre version is not supported
    else {
      fail('ERROR: jre version is not recognized')
    }
  }
  
  # else install the custom (or Oracle supplied) package
  else {
    
    # validate the path of the jre is a valid path
    validate_absolute_path($jrepath)
    
    # install a jdk package
    package { 'jre':
      name   => $jrepackage,
      ensure => $jreensure,
    }
  }
  
  # if the jre being installed is the primary one 
  if $primary_jre == 'yes' {
        
    # place the profile.d script for the jdk 
    file { 'jre.sh':
      ensure  => 'present',
      path    => '/etc/profile.d/jre.sh',
      content => template('java/jre.sh.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => 0655,
      require => Package['jre'],
    }
  }
}