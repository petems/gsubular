class nginx {
  package {'nginx': }
  file {'/etc/nginx':
    recurse                        =>true,
    purge                          =>true,
    force                          =>true,
    source                         =>'puppet:///modules/nginx/etc/nginx'
  }
  file {'/etc/nginx/nginx.conf':
    content=>template('nginx/nginx.conf.erb')
  }
  service {'nginx':
    require =>File['/etc/nginx/nginx.conf'],
    subscribe =>File['/etc/nginx'],
    enable =>true,ensure=>running
  }
  exec {'create-nginx-user':
    command => '/usr/sbin/useradd nginx'
    unless => 'grep "^nginx:" /etc/passwd'
  }
}
