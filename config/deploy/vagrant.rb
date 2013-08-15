port =
  Bundler.with_clean_env do
  `vagrant ssh-config`.to_s[/^\s+Port\s(\d+)/, 1]
end

server "localhost:#{port}", :app, :web
set :server_name, "192.168.30.3"
set :user,        "vagrant"
set :password,    "vagrant"