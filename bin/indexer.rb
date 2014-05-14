#!/usr/bin/env ruby
require File.expand_path '../../config/application',  __FILE__
Rails.application.require_environment!

require 'open3'
require 'fileutils'
require 'tempfile'
require 'stretcher'

def execute(*args)
	#print *args.join(' '), "\n"
	Open3.capture3 *args
end

es = Stretcher::Server.new 'http://localhost:9200/'
es.index :nsa do |index|
	index.type :page do |index|

		ARGV.each do |pdf|
			doc = File.basename pdf, '.pdf'

			print "Converting #{pdf}\n"
			o, _ = execute 'identify', '-format', '%n', pdf
			pages = o.to_i
			print "  #{pages} pages found\n"

			pages.times do |n|
				print "  Converting page #{n}/#{pages}\n"
				name = "#{doc}-#{n}"
				page = "#{pdf}[#{n}]"
				png = File.join Document::PNG_PATH, "#{name}.png"
				png_small = File.join Document::PNG_SMALL_PATH, "#{name}.png"
				txt = File.join Document::TXT_PATH, name

				Tempfile.create [name, '.tif'] do |tif|
					execute 'convert', '-density', '300', '-depth', '8', page, tif.to_path
					execute 'tesseract', '-l', 'eng', '-psm', '1', tif.to_path, txt
					execute 'convert', '-resize', '1024x', '-density', '120', tif.to_path, png
					execute 'convert', '-resize', '400x', png, png_small

					content = File.read "#{txt}.txt"
					index.put name, {doc: doc, page: n, content: content}
				end
			end

			Document.create! name: doc, pages: pages
			FileUtils.move pdf, Document::PDF_PATH
		end
	end
end
