require 'capistrano/setup'
require 'capistrano/deploy'

require 'capistrano/rsync'
require 'capistrano/git'

require 'capistrano/rbenv'
require 'capistrano/bundler'

# require 'capistrano/rails/migrations'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

namespace :deploy do
	after :finishing, 'deploy:cleanup'
end

invoke :staging
