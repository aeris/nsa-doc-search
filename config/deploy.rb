lock '3.2.1'

set :application, 'nsa-doc-search'

set :rbenv_custom_path, '/usr/local/rbenv'
set :rbenv_type, :user
set :rbenv_path, '/usr/local/rbenv'
set :rbenv_ruby, '2.1.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} /usr/bin/env rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

set :bundle_without, %i(test).join(' ')

set :user, :root
set :deploy_to, '/opt/nsa-observer/doc-search'
set :rails_env, :production

set :scm, :git
set :repo_url, 'git@github.com:aeris/nsa-doc-search.git'
set :branch, Proc.new { fetch :stage }
