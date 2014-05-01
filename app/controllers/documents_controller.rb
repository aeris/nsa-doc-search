class DocumentsController < ApplicationController
	respond_to :pdf

	def show
		document = params[:id]
		document = File.join Rails.configuration.documents_path, 'pdf', "#{document}.pdf"
		send_file document, type: 'application/pdf', disposition: :inline
	end
end
