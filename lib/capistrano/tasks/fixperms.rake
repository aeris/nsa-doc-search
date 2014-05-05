task :fixperms do
	run %W(chown -R www-data:www-data #{latest_release}/)
end
