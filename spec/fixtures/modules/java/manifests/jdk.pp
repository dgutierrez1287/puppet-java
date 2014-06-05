# define java::jdk
#
# This define will install the jdk and set up a profile script
# if the jdk is set to be the primary jdk, this will install a
# an openjdk by default (a version of the openjdk) can be specified
# or it will install a custom jdk package that can be specified.
#
# Parameters:
# name(title) - This parameter serves no purpose other then being required by puppet
# jdkpackage - A custom jdk package to be installed
# jdkensure - The ensure for the custom or openjdk package, this must be present or absent for openjdk but can be a version for a custom jdk
# jdkpath - the path where the jdk is installed too, this is only mandatory if its a custom jdk package otherwise this is already prefilled
# openjdk_version - the version of the openjdk to install, currently only version 6 and 7 are supported
# primary_jdk - this must be either yes or no, this will set the JDK_HOME and JAVA_HOME in the profile script if it is set to yes
#
define java::jdk (
  $jdkname = $title,
  $jdkpackage = '',
  $jdkensure = 'present',
  $jdkpath = '',
  $openjdk_version = 6,
  $primary_jdk = 'yes',
) {

  # validate params
  validate_string($jdkpackage)
  validate_string($jdkensure)
  validate_string($primary_jdk)

  # fail if the primary_jdk is not set to yes or no
  if ! ($primary_jdk in [ 'yes', 'no' ]) {
    fail ('ERROR: primary_jdk must be set to yes or no')
  }

  # validate params based on package_name
  # if there is no package_name given the install the openjdk
  if $jdkpackage == '' {
    # fail if there is a supplied ensure that is not present or absent
    if ! ($jdkensure in [ 'present', 'absent' ]) {
      fail('ensure is not valid for using openjdk, must be present or absent')
    }

    # fail if the openjdk_version is not a number
    if ! is_integer($openjdk_version) {
      fail('ERROR: openjdk_version must be a number')
    }

    # set jdk_path based on openjdk_version and osfamily
    # if the jdk version is 6
    if $openjdk_version == 6 {
      # set jdk_path based on osfamily
      case $::osfamily {
        # if the osfamily is redhat
        'RedHat': {
          $openjdk_path = "/usr/lib/jvm/java-1.6.0-openjdk.${::architecture}"

          package { 'jdk':
            ensure => $jdkensure,
            name   => 'java-1.6.0-openjdk-devel',
          }
        }
        # if the osfamily is debian
        'Debian': {
          $openjdk_path = "/usr/lib/jvm/java-1.6.0-openjdk-${::architecture}"

          package { 'jdk':
            ensure => $jdkensure,
            name   => 'openjdk-6-jdk',
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
      case $::osfamily {
        # if the osfamily is redhat
        'RedHat': {
          $openjdk_path = "/usr/lib/jvm/java-1.7.0-openjdk.${::architecture}"

          package { 'jdk':
            ensure => $jdkensure,
            name   => 'java-1.7.0-openjdk-devel',
          }
        }
        # if the osfamily is debian
        'Debian': {
          $openjdk_path = "/usr/lib/jvm/java-1.7.0-openjdk-${::architecture}"

          package { 'jdk':
            ensure => $jdkensure,
            name   => 'openjdk-7-jdk',
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

  # else install the custom (or Oracle supplied) package
  else {

    # validate the path of the jdk is a valid path
    validate_absolute_path($jdkpath)

    # install a jdk package
    package { 'jdk':
      ensure => $jdkensure,
      name   => $jdkpackage,
    }
  }

  # if the jdk being installed is the primary one
  if $primary_jdk == 'yes' {
    # place the profile.d script for the jdk
    file { 'jdk.sh':
      ensure  => 'present',
      path    => '/etc/profile.d/jdk.sh',
      content => template('java/jdk.sh.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0655',
      require => Package['jdk'],
    }
  }
}
