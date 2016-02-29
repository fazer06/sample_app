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

	# Remembers a user in a persistent session.
	def remember(user)
		# calls user.remember in app/models/user.rb
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	# Returns the user corresponding to the remember token cookie.
	def current_user
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			if user && user.authenticated?(cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end

	# Returns TRUE if the user in the session (current_user) is logged in, 
	# otherwise it returns FALSE.
  	def logged_in?
    	!current_user.nil?
  	end

	# Forgets a persistent session.
	def forget(user)
		user.forget
		# deletes the user_id
		cookies.delete(:user_id)
		# deletes the remember_token
		cookies.delete(:remember_token)
	end

	# Logs out the current user.
	def log_out
		# Forget the current user when they logout by calling the forget helper above
		forget(current_user)
		# Delete the user id from the session
		session.delete(:user_id)
		# Set the current user to nil
		@current_user = nil
	end

end
