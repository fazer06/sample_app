class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			# Calls the log_in helper in app/helpers/sessions_helper.rb
			log_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			render 'new'
		end
	end

	private

		def user_params
			params.require(:user).permit( :username, 
										  :email, 
										  :password, 
										  :password_confirmation )
		end

end
