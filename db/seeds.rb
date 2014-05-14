ActiveRecord::Base.transaction do
	Dir["#{Document::PDF_PATH}/*.pdf"].each do |doc|
		o, _ = Open3.capture2e 'identify', '-format', '%n', doc
		name = File.basename doc, '.pdf'
		pages = o.to_i
		p Document.create! name: name, pages: pages
	end
end
