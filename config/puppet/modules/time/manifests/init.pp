class time {

  file { '/etc/localtime':
    ensure => link,
    target => '/usr/share/zoneinfo/Europe/London',
  }

  file { '/etc/timezone':
    content => 'Etc/UTC',
  }

  file { '/etc/default/locale':
    ensure  => present,
    content => template('time/etc/default/locale.erb')
  }

}
