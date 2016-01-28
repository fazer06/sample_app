Rails.application.routes.draw do

	# Define which page is the root of the application
	root 'static_pages#home'
	# By using get we arrange for the route to respond to a GET request
	# get a page at some address http://localhost:3000/static_pages/home
	get 'static_pages/help'
	get 'static_pages/about'

end
