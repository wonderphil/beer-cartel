# config valid only for current version of Capistrano


set :application, "beer"
set :repo_url, "ssh://git@stash:7999/ops/beer.git"


set :deploy_to, "/home/ubuntu/apps/#{fetch(:application)}"
set :deploy_user, "ubuntu"

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, "2.2.2"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :keep_releases, 5



