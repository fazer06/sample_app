module ApplicationHelper

	# The full title helper returns the page title on a per page basis
	
	# Define the full_title method and pass it the page_title argument
	# The page_title variable has a default value of an empty string
	def full_title(page_title = '') 
		# Define the base_title variable
		base_title = "Ruby on Rails Tutorial Sample App"
		# Boolean test
		if page_title.empty?
			# Return the base title (return is optional, we can just use base_title)
			return base_title
		else
			# Return the page_title with string concatenation and the base_title
			return page_title + " | " + base_title
		end
	end

end
