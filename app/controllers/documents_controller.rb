class DocumentsController < ApplicationController
	respond_to :pdf
	PDF_PATH = File.join Rails.configuration.documents_path, 'pdf'

	def index
		@documents = Dir["#{PDF_PATH}/*.pdf"].collect { |file| File.basename file, '.pdf' }.sort
	end

	def show
		document = pdf params[:id]
		send_file document, type: 'application/pdf', disposition: :inline
	end

	private
	def pdf(id)
		File.join PDF_PATH, "#{id}.pdf"
	end
end
