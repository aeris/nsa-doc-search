require 'capistrano/setup'
require 'capistrano/deploy'

require 'capistrano/rbenv'
require 'capistrano/bundler'

require 'capistrano/rails/assets'
# require 'capistrano/rails/migrations'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

namespace :deploy do
	after :finishing, 'deploy:cleanup'
	after 'deploy:publishing', 'deploy:restart'
end

invoke :staging
