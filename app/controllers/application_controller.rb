class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	def bool(name, default=nil)
		p = params[name]
		return default.nil? ? nil : default if p.nil?
		%w(1 on o true t yes y).include? p.to_s
	end

	def int(name, default=nil)
		p = params[name]
		return default.nil? ? nil : default if p.nil?
		p.to_i
	end
end
