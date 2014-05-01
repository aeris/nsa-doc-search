class PagesController < ApplicationController
	respond_to :png

	def show
		document = params[:document_id]
		page = params[:id]
		document = File.join Rails.configuration.documents_path, 'png-small', "#{document}-#{page}.png"
		send_file document, type: 'image/png', disposition: :inline
	end
end
