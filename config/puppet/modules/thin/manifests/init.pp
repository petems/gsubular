# == Class: thin
#
# This class installs Thin
#
class thin (
  $config_dir         = '/etc/thin.d',
  $log_dir            = '/var/log/thin',
  $pid_dir            = '/var/run/thin',
  $package_type       = 'package',
  $service            = 'thin',
  $service_ensure     = 'running',
  $service_enable     = true,
  $service_hasstatus  = false,
  $service_hasrestart = true,
  $service_pattern    = 'thin server'
) {

  case $package_type {
    'gem'    : { include ruby::gem::thin }
    'package': { include ruby::package::thin }
    default  : { fail "Unsupported package type ${package_type}" }
  }

  # resource alias is only usable for require
  # realize Package[thin] doesn't work if thin
  # is an alias, see http://projects.puppetlabs.com/issues/4459
  Package <| alias == 'ruby-thin' |>

  file {[$config_dir, $log_dir]:
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
  }

  file {$pid_dir:
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '1777',
  }

  file {"/etc/init.d/${service}":
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/thin/thin.init',
  }

  service {$service:
    ensure     => $service_ensure,
    enable     => $service_enable,
    hasstatus  => $service_hasstatus,
    hasrestart => $service_hasrestart,
    pattern    => $service_pattern,
    require    => [
      File[$config_dir,$log_dir,$pid_dir],
      File["/etc/init.d/${service}"], Package['ruby-thin'],
    ],
  }

}
