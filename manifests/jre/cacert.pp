#define java::jre::cacert
#
# this define will allow you to push a custom
# cacert to a jre install 
#
# Parameters:
# cacertpath(title) - the path to the cacert file that you would like installed
# owner - the owner of the cacert, the default is root
# group - the group owner of the cacert, the default is root
# mode - the mode of the cacert file, the default is root
# ensure - this the ensure of the cacert file, the default is present
# jrepath - the path where the jdk is installed too that you want to add the cacert to
# jre_version - the version of the openjdk-jre that was installed, if intalled instead of a custom package
#
define java::jre::cacert (
  $cacertpath = $title,
  $owner = 'root',
  $group = 'root',
  $mode = '0644',
  $ensure = 'present',
  $jrepath = '',
  $openjre_version = 6,
){
  
  # validate parameters
  validate_string($cacertpath)
  validate_string($owner)
  validate_string($group)
  
  # check size of parameters
  if size($cacertpath) == 0 {
    fail('ERROR: cacertpath cannot be empty')
  }
  if size($owner) == 0 {
    fail('ERROR: owner cannot be empty')
  }
  if size($group) == 0 {
    fail('ERROR: group cannot be empty')
  }
  
  # make sure that ensure has to be set to present or absent
  if ! ($ensure in [ 'present', 'absent' ]) {
    fail('ERROR: the ensure must be either present or absent')
  }
  
  if $jrepath == '' {
        
    # fail if the openjdk_version is not a number
    if ! is_integer($openjre_version) {
      fail('ERROR: openjdk_version must be a number')
    }
    
    # set jdk_path based on jre_version and osfamily
    # if the jre version is 6
    if $openjre_version == 6 {
      
      # set jdk_path based on osfamily
      case $osfamily {
        # if the osfamily is redhat 
        'RedHat': {
          #$jrepath = "/usr/lib/jvm/jre-1.6.0"
         
          # push out the cacert file
          file { "/usr/lib/jvm/jre-1.6.0/jre/lib/security/cacerts":
            owner => $owner,
            group => $group,
            mode => $mode,
            ensure => $ensure,
            source => $cacertpath,
          }
        }
        # if the osfamily is debian
        'Debian': {
          #$jrepath = "/usr/lib/jvm/java-1.6.0-openjdk"
          
          # push out the cacert file
          file { "/usr/lib/jvm/java-1.6.0-openjdk/jre/lib/security/cacerts":
            owner => $owner,
            group => $group,
            mode => $mode,
            ensure => $ensure,
            source => $cacertpath,
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
      # set jrepath based on osfamily
      case $osfamily {
        # if the osfamily is redhat 
        'RedHat': {
          #$jrepath = "/usr/lib/jvm/jre-1.7.0"
          
          # push out the cacert file
          file { "/usr/lib/jvm/jre-1.7.0/jre/lib/security/cacerts":
            owner => $owner,
            group => $group,
            mode => $mode,
            ensure => $ensure,
            source => $cacertpath,
          }
        }
        # if the osfamily is debian
        'Debian': {
          #$jrepath = "/usr/lib/jvm/java-1.7.0-openjdk"
          
          # push out the cacert file
          file { "/usr/lib/jvm/java-1.7.0-openjdk/jre/lib/security/cacerts":
            owner => $owner,
            group => $group,
            mode => $mode,
            ensure => $ensure,
            source => $cacertpath,
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
  else {
    # push out the cacert file
    file { "${jrepath}/jre/lib/security/cacerts":
      owner => $owner,
      group => $group,
      mode => $mode,
      ensure => $ensure,
      source => $cacertpath,
    }
  }
}