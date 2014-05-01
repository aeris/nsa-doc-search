Rails.application.assets.context_class.class_eval do
	def path(name, params=[], **options)
		helper = "#{name}_path"
		names = []
		replace = []
		params.each_with_index do |n, p|
			arg = "__p#{p}__"
			names << arg
			replace << [arg, "\#{#{n}}"]
		end
		query_params = options.delete :params
		unless query_params.nil?
			query_params.each_with_index do |n, p|
				arg = "__q#{p}__"
				names << arg
				replace << [arg, "\#{#{n}}"]
				options[n] = arg
			end
		end

		path = Rails.application.routes.url_helpers.send helper, *names, **options
		replace.each { |p, n| path.sub! p, n }
		"#{config.relative_url_root}#{path}"
	end
end
