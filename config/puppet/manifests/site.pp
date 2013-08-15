Exec {
  path=>'/usr/bin:/bin',
  logoutput=>on_failure
}

class { 'nginx': }

nginx::vhost {'gsubular':
  template=>'nginx.conf.erb',
}

file { "/etc/profile.d/rack_prod.sh"
  content => "export RACK_ENV=production"
}

class { ruby: version => '2.0.0-p0' }

exec {'gem-install-bundler':
  command=>'/usr/bin/gem install bundler',
  unless=>'/usr/bin/gem which bundler',
  require=>Class['ruby']
}