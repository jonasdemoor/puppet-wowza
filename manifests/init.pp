# == Class: Wowza
# Wowza module. This module installs and configures a wowza streaming engine,
# the package for the wowzastreamingengine needs to be available in a local
# repository.
#
# === Examples
#
#  Minimal installation and configuration:
#
#  class {wowza:
#    wowzakey => 'xxxx-xxxx-xxxx-xxxx'
#  }
#
#  See params.pp for the various configuration parameters
#
# === Authors
#
#  Kristof Keppens <kristof@inuits.eu>
#

class wowza (
  $wowzakey,
  $admin_password       = $wowza::params::admin_password,
  $admin_user           = $wowza::params::admin_user,
  $enable               = $wowza::params::enable,
  $enable_manager       = $wowza::params::enable_manager,
  $java_heap_size       = $wowza::params::java_heap_size,
  $java_pkg             = $wowza::params::java_pkg,
  $wowza_pkg            = $wowza::params::wowza_pkg,
  $wowza_pkg_version    = $wowza::params::wowza_pkg_version,
  $loadtest_ensure      = $wowza::params::loadtest_ensure,
  $loadtest_workercount = $wowza::params::loadtest_workercount,
  $loadtest_streamname  = $wowza::params::loadtest_streamname,
  $loadtest_target      = $wowza::params::loadtest_target,
) inherits wowza::params {
  ##
  #This is the main wowza class.
  # This module is used to set up a wowza streaming serverconfig
  #
  # ==Actions
  # Install a wowza streaming server with basic config
  #


  class {'wowza::install':;} ~>
    class {'wowza::serverconfig':;} ~>
    class {'wowza::setenv':;} ~>
    class {'wowza::service':;}

  class {
    'wowza::loadtest':
        ensure  => $wowza::loadtest_ensure,
  }
}
