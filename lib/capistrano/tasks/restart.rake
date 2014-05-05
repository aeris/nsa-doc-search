namespace :deploy do
	task :restart do
		on release_roles :app do
			execute :touch, release_path.join('tmp/restart.txt')
		end
	end
end

after 'deploy:publishing', 'deploy:restart'
