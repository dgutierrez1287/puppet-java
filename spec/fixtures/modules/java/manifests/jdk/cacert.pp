#define java::jdk::cacert
#
# this define will allow you to push a custom
# cacert to a jdk install 
#
# Parameters:
# cacertpath(title) - the path to the cacert file that you would like installed
# owner - the owner of the cacert, the default is root
# group - the group owner of the cacert, the default is root
# mode - the mode of the cacert file, the default is root
# ensure - this the ensure of the cacert file, the default is present
# jdkpath - the path where the jdk is installed too that you want to add the cacert to
# openjdk_version - the version of the openjdk that was installed, if intalled instead of a custom package
#
define java::jdk::cacert (
  $cacertpath = $title,
  $owner = 'root',
  $group = 'root',
  $mode = '0644',
  $ensure = 'present',
  $jdkpath = '',
  $openjdk_version = 6,
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
  
  if $jdkpath == '' {
        
    # fail if the openjdk_version is not a number
    if ! is_integer($openjdk_version) {
      fail('ERROR: openjdk_version must be a number')
    }
    
    # set jdk_path based on openjdk_version and osfamily
    # if the jdk version is 6
    if $openjdk_version == 6 {
      
      # set jdk_path based on osfamily
      case $osfamily {
        # if the osfamily is redhat 
        'RedHat': {
          file { "/usr/lib/jvm/java-1.6.0-openjdk.${architecture}/jre/lib/security/cacerts":
            owner  => $owner,
            group  => $group,
            mode   => $mode,
            ensure => $ensure,
            source => $cacertpath,
          }
        }
        # if the osfamily is debian
        'Debian': {
          file { "/usr/lib/jvm/java-1.6.0-openjdk-${architecture}/jre/lib/security/cacerts":
            owner  => $owner,
            group  => $group,
            mode   => $mode,
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
    # if the jdk version is 7
    elsif $openjdk_version == 7 {
      # set jdk_path based on osfamily
      case $osfamily {
        # if the osfamily is redhat 
        'RedHat': {
          file { "/usr/lib/jvm/java-1.7.0-openjdk.${architecture}/jre/lib/security/cacerts":
            owner  => $owner,
            group  => $group,
            mode   => $mode,
            ensure => $ensure,
            source => $cacertpath,
          }
        }
        # if the osfamily is debian
        'Debian': {
          file { "/usr/lib/jvm/java-1.7.0-openjdk-${architecture}/jre/lib/security/cacerts":
            owner  => $owner,
            group  => $group,
            mode   => $mode,
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
    # else fail since the jdk version is not supported
    else {
      fail('ERROR: jdk version is not recognized')
    }
  }
  else {
    # push out the cacert file
    file { "${jdkpath}/jre/lib/security/cacerts":
      owner  => $owner,
      group  => $group,
      mode   => $mode,
      ensure => $ensure,
      source => $cacertpath,  
    }
  }
}