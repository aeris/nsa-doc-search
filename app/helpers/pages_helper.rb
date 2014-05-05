module PagesHelper
	def page_link(page, content=nil, active: nil, disabled: nil)
		text = content.nil? ? page : content
		clazz = []
		if disabled
			clazz << :disabled
			link = link_to text, nil
		else
			clazz << :active if active
			link = link_to text, pages_path(filter: @filter, size: @size,
																 with_text: @with_text, page: page)
		end
		content_tag :li, link, class: clazz
	end
end
