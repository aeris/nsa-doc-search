class DocumentsController < ApplicationController
	#respond_to :pdf

	def index
		@documents = Document.all.sort_by &:name
	end

	def show
		@document = Document.find_by! name: params[:id]

		respond_to do |format|
			format.pdf do
				send_file @document.pdf, type: 'application/pdf'
			end
			format.text do
				self.content_type = 'text/plain'
				self.response_body = @document.pages.times.collect { |n| @document.content n }
			end
		end
	end
end
