task :precompile do
	Dir.chdir fetch :rsync_stage do
		system({ 'RAILS_ENV' => fetch(:rails_env).to_s }, 'bundle', 'exec', 'rake', 'assets:precompile')
	end
end

after 'rsync:stage', 'precompile'
