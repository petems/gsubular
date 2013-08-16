# Definition: thin::app
#
# Easily add and start Rails application
#
# Parameters:
# - The $chdir to go inside dir before starting
# - The $user to run daemon as
# - The $group to run daemon as
# - The $rackup Rack config to load
# - The $ensure specifies if thin::app is present or absent
# - The $address to bind to (default localhost)
# - The $port to use (default 3000)
# - Request or command $timeout in sec (default 30s)
# - Number of $servers to start
# - Run $daemonize(d) in the backgroup (default true)
#
# Sample Usage:
#  thin::app {'myapp':
#     ensure  => present,
#     address => 'localhost',
#     port    => '3001',
#     chdir   => '/opt/myapp',
#     user    => 'myapp',
#     group   => 'myapp',
#     rackup  => "/opt/myapp/config.ru",
#     require => ...
#  }
#
define thin::app (
  $chdir,
  $user,
  $group,
  $rackup,
  $ensure     = present,
  $address    = 'localhost',
  $port       = '3000',
  $timeout    = '30',
  $servers    = $::physicalprocessorcount,
  $daemonize  = true,
) {

  file {"${thin::config_dir}/${name}.yml":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('thin/app.yml.erb'),
    notify  => Service[$thin::service],
    require => File[$thin::config_dir],
  }

}
