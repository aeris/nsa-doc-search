#!/usr/bin/env ruby
require 'stretcher'

es = Stretcher::Server.new('http://nsa.local:9200/')
es.index :nsa do |index|
	index.delete if index.exists?
	index.create mappings: {
			  page: {
						 properties: {
									doc: {type: :string},
									page: {type: :integer},
									content: {type: :string}
						 }
			  }
	}

	index.type :page do |pages|
		r = /(.*)-(\d+).txt/
		Dir['../../../ocr/txt/*.txt'].each do |txt|
			file = File.basename txt
			m = r.match file
			doc, page = m[1], m[2].to_i
			content = File.read txt
			pages.put file, {doc: doc, page: page, content: content}
		end
	end

	index.search(query: { match: { content: 'XKEYSCORE' } }).results.each do |match|
		p match.doc, match.page
	end
end
