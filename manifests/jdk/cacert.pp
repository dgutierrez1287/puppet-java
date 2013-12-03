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
#
define java::jdk::cacert (
  $cacertpath = $title,
  $owner = 'root',
  $group = 'root',
  $mode = '0644',
  $ensure = 'present',
  $jdkpath = '',
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
  
  # push out the cacert file
  file { "${jdkpath}jre/lib/security/cacerts":
    owner => $owner,
    group => $group,
    mode => $mode,
    ensure => $ensure,
    source => $cacertpath,
  }
}