define nginx::reverse_proxy(
  $ssl_key,
  $ssl_certificate,
  $document_root,
  $upstream_http_socket,
  $upstream_xhr_socket,
  $server_name,
  $application_name,
  $application_root) {
  $conf_file_name = "/etc/nginx/conf.d/${title}.site.conf"

  file {$conf_file_name:
    notify =>Service['nginx'],
    content=>template('nginx/application.conf.erb')
  }
}
