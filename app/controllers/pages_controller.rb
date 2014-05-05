class PagesController < ApplicationController
	respond_to :png, only: %i(show)

	def index
		@filter = params[:filter]
		@with_text = bool :with_text, false
		@size = int :size, 10
		@page = int :page, 1
		from = (@page-1) * @size
		if @filter.nil?
			@results = nil
		else
			es = Rails.configuration.es.index(:nsa)
						.search(size: @size, from: from, query: {match: {content: @filter}})
			@results = { total: es.total }
			results = es.results.collect do |match|
				p = {doc: match.doc, page: match.page}
				p[:text] = match.content
				.gsub(Regexp.new(Regexp.escape(@filter), Regexp::IGNORECASE), '<span class="highlight">\0</span>')
				.gsub("\n+", '<br/>') if @with_text
				p
			end
			results.sort! do |x, y|
				c = x[:doc] <=> y[:doc]
				c = x[:page] <=> y[:page] if c == 0
				c
			end
			@results[:items] = results
		end

		respond_to do |format|
			format.html
			format.json { render json: @results }
		end
	end

	def show
		document = params[:document_id]
		page = params[:id]
		document = File.join Rails.configuration.documents_path, 'png-small', "#{document}-#{page}.png"
		send_file document, type: 'image/png', disposition: :inline
	end
end
