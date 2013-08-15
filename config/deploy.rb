require 'capistrano/ext/puppetize'
require 'bundler/capistrano'
require 'capistrano/ext/multistage'

set :bundle_cmd, "bundle"
set :bundle_without, [:development, :test, :profile]

set :whenever_command, "#{fetch(:bundle_cmd)} exec whenever"

set :ssh_private_key, File.expand_path("#{ENV['HOME']}/.ssh/id_rsa")
set :ssh_options,{keys: fetch(:ssh_private_key), forward_agent: true}

set :application, "gsubular"

set :scm, :git
set :repository, "https://github.com/petems/gsubular"
set :deploy_via, :remote_cache

set :default_stage, "vagrant"
set :stages, %w(vagrant staging production)

set :app_host_name, "gsubular"

set :deploy_to, "/opt/gsubular"

current_git_branch = `git branch`.match(/\* (\S+)\s/m)[1]

set :branch, current_git_branch

default_run_options[:pty] = true

set :owner, ENV['USER']

before 'deploy', 'deploy:check'

namespace :deploy do
  task :start, :roles => [:web, :app] do
    run "cd #{deploy_to}/current"
  end

  task :stop, :roles => [:web, :app] do
    run "cd #{deploy_to}/current"
  end

  task :restart, :roles => [:web, :app] do
    deploy.stop
    deploy.start
  end

  task :cold do
    deploy.update
    deploy.start
    deploy.nginx_restart
  end
end

namespace :deploy do
  task :migrate do
    puts "    not doing migrate because not a Rails application."
  end
  task :finalize_update do
    puts "    not doing finalize_update because not a Rails application."
  end
end