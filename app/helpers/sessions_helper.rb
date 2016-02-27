module SessionsHelper

	# Define the method log_in because we need to use the same login 
	# technique in a couple of places
	def log_in(user)
		# Place a TEMPORARY session cookie on the user’s browser containing an 
		# encrypted version of the user’s id, which allows us to retrieve 
		# the id on subsequent pages using session[:user_id] 
		# This temporary cookie created by the session method expires 
		# immediately when the browser is closed.
		session[:user_id] = user.id
	end

	# Returns the current logged-in user (if any).
	def current_user
		# ||= (or equals)
		# The current_user = the current_user OR it grabs the information from 
		# the browser in the cookie, decrypts it and pulls out the user id
		@current_user ||= User.find_by(id: session[:user_id])
	end

	# Returns TRUE if the user in the session (current_user) is logged in, 
	# otherwise it returns FALSE.
  	def logged_in?
    	!current_user.nil?
  	end

	# Logs out the current user.
	def log_out
		# Delete the user id from the session
		session.delete(:user_id)
		# Set the current user to nil
		@current_user = nil
	end

end
