define nginx::vhost($source=false, $template=false) {
  if $template {
    File {
      content => template($template)
    }
  }
  if $source {
    File {
      source => $source
    }
  }
  file{"/etc/nginx/conf.d/${name}.site.conf":
    path  => $fname,
    owner => nginx,
    mode  => '0644',
  }
}
