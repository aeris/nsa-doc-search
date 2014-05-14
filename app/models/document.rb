class Document < ActiveRecord::Base
	PDF_PATH = File.join Rails.configuration.documents_path, 'pdf'
	TXT_PATH = File.join Rails.configuration.documents_path, 'txt'
	PNG_PATH = File.join Rails.configuration.documents_path, 'png'
	PNG_SMALL_PATH = File.join Rails.configuration.documents_path, 'png-small'

	validates :name, presence: true, uniqueness: true
	validates :pages, presence: true, numericality: { only_integer: true }

	def pdf
		File.join PDF_PATH, "#{self.name}.pdf"
	end

	def txt(page)
		File.join TXT_PATH, "#{self.name}-#{page.to_i}.txt"
	end

	def content(page)
		File.read self.txt page
	end

	def png(page, small: true)
		File.join (small ? PNG_SMALL_PATH : PNG_PATH), "#{self.name}-#{page.to_i-1}.txt"
	end

	def to_param
		self.name
	end
end
