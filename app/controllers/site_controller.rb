class SiteController < ApplicationController
	protect_from_forgery except: :search

	def index
	end

	def search
		filter = params[:filter]
		result = Rails.configuration.es.index(:nsa)
			.search(query: { match: { content: filter } })
			.results.collect do |match|
			content = match.content
				.gsub(Regexp.new(Regexp.escape(filter), Regexp::IGNORECASE), '<span class="highlight">\0</span>')
				.gsub("\n+", '<br/>')
			{ doc: match.doc, page: match.page, content: content }
		end
		result.sort! do |x, y|
			c = x[:doc] <=> y[:doc]
			c = x[:page] <=> y[:page] if c == 0
			c
		end

		respond_to do |format|
			format.json { render json: result.to_json }
		end
	end
end
