task :fixperms do
	on release_roles :app do
		execute 'chown', '-R', 'www-data:www-data', release_path
	end
end

before 'deploy:publishing', 'fixperms'
