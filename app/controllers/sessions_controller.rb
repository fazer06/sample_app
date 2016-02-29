class SessionsController < ApplicationController

	def new
	end

	def create
		# Pull the user out of the database using the submitted email address
		user = User.find_by(email: params[:session][:email].downcase)
		# The if statement is true only if a user with the given email both 
		# exists in the database and has the given password, exactly as required
		if user && user.authenticate(params[:session][:password])
		# Call the log_in method from app/helpers/session_helper.rb
		#debugger # Uncomment to view the params hash in the server logs
		log_in user
		# Remember the user if the checkbox is ticked on the login form
		params[:session][:remember_me] == '1' ? remember(user) : forget(user)
		# Redirect back or to the users show page, after successful login
		redirect_to user
		else
			# Unlike a redirect a render uses flash.now
      		flash.now[:danger] = 'Invalid email/password combination'
      		render 'new'
  		end
	end

	def destroy
		# Call the log_out method from app/helpers/session_helper.rb
		log_out if logged_in?
		# Redirect to the root url
		redirect_to root_url
	end
end
