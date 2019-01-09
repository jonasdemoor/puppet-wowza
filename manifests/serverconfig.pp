# == Class: wowza::serverconfig
#  Class that does the default configuration for the wowzastreamingengine server.
#

class wowza::serverconfig(
  $admin_user           = $wowza::admin_user,
  $admin_password       = $wowza::admin_password,
  $enable_logrotation   = $wowza::enable_logrotation,
  $log_max_file_size    = $wowza::log_max_file_size,
  $log_max_backup_index = $wowza::log_max_backup_index,
) {

  file { "${::wowza::installdir}/conf/Server.license":
    content => $::wowza::wowzakey,
  }

  #change permissions for the folders
  file { "${::wowza::installdir}/logs":
    ensure => 'present',
    mode   => '0775',
    owner  => 'root',
    group  => 'root',
  }

  file { "${::wowza::installdir}/conf":
    ensure => 'present',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

  file { "${::wowza::installdir}/applications":
    ensure => 'present',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

  file { "${::wowza::installdir}/content":
    ensure => 'present',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

  file { "${::wowza::installdir}/keys":
    ensure => 'present',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

  file { "${::wowza::installdir}/transcoder":
    ensure => 'present',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

  file { "${::wowza::installdir}/conf/admin.password":
    ensure  => 'present',
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    content => template('wowza/admin.password.erb'),
  }

  #Change log configuration to log statistics in an awstats understandable format
  #Also create logs for each separate vhost and applications
  file { "${::wowza::installdir}/conf/log4j.properties":
    ensure  => 'present',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    replace => true,
    content => template('wowza/log4j.properties.erb'),
    notify  => Class['wowza::service'],
  }
}
