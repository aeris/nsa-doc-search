task :precompile do
	Dir.chdir fetch :rsync_stage do
		system({ RAILS_ENV: fetch :rails_env }, 'rake', 'assets:precompile')
	end
end

before 'rsync:stage', 'precompile'
