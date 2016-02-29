# == Route Map
#
#    Prefix Verb   URI Pattern               Controller#Action
#      root GET    /                         static_pages#home
#      help GET    /help(.:format)           static_pages#help
#     about GET    /about(.:format)          static_pages#about
#    signup GET    /signup(.:format)         users#new
#     login GET    /login(.:format)          sessions#new
#           POST   /login(.:format)          sessions#create
#    logout DELETE /logout(.:format)         sessions#destroy
#     users GET    /users(.:format)          users#index
#           POST   /users(.:format)          users#create
#  new_user GET    /users/new(.:format)      users#new
# edit_user GET    /users/:id/edit(.:format) users#edit
#      user GET    /users/:id(.:format)      users#show
#           PATCH  /users/:id(.:format)      users#update
#           PUT    /users/:id(.:format)      users#update
#           DELETE /users/:id(.:format)      users#destroy
#

Rails.application.routes.draw do

	# Define which page is the root of the application
	root 'static_pages#home'
	
	# Named Routes

	# By using get we arrange for the route to respond to a GET request
	# get a page at some address http://localhost:3000/help

	# VERB	/url  	  =>  	'controller#action'
	get     'help'    =>	'static_pages#help'
	get     'about'   =>	'static_pages#about'
	get     'signup'  =>	'users#new'
	get 	'login'   => 	'sessions#new'
	post 	'login'   => 	'sessions#create'
	delete 	'logout'  => 	'sessions#destroy'

	# The users resource lets us respond to the full suite of RESTful URLs

	# Prefix    Verb    URI Pattern       Controller#Action
	# users     GET     /users            users#index
	#           POST    /users            users#create
	# new_user  GET     /users/new        users#new
	# edit_user GET     /users/:id/edit   users#edit
	# user      GET     /users/:id        users#show
	#           PUT     /users/:id        users#update
	#           PATCH   /users/:id        users#update
	#           DELETE  /users/:id        users#destroy

	resources :users

end
