require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:fazer)
	end

	# Test login with invalid information
	test "login with invalid information" do
		# Visit the login path
		get login_path
		# Verify that the new sessions form renders properly
		assert_template 'sessions/new'
		# Post to the sessions path with an invalid params hash
		post login_path, session: { email: "", password: "" }
		# Verify that the new sessions form gets re-rendered
		assert_template 'sessions/new'
		# Verify that a flash message appears
		assert_not flash.empty?
		# Visit the root path
		get root_path
		# Verify that the flash message doesn’t appear on the new page
		assert flash.empty?
	end

	# Test login with valid information
	test "login with valid information followed by logout" do
		# Visit the login path.
		get login_path
		# Post valid information to the sessions path.
		post login_path, session: { email: @user.email, password: 'password' }
		# Check the user is logged in   
		assert is_logged_in?
		# Redirect to user page
		assert_redirected_to @user
		# Follow the redirect
		follow_redirect!
		# Verify that the users profile page renders properly
		assert_template 'users/show'
		# Verify that the login link disappears.
		assert_select "a[href=?]", login_path, count: 0
		# Verify that a logout link appears.
		assert_select "a[href=?]", logout_path
		# Verify that a profile link appears.
		assert_select "a[href=?]", user_path(@user)
		# Issue a DELETE request to the logout path
		delete logout_path
		# Check the user is NOT logged in
		assert_not is_logged_in?
		# redirected to the root URL
		assert_redirected_to root_url

		# Simulate a user clicking logout in a second window.
		#delete logout_path

		# Follow the redirect to root url
		follow_redirect!
		# Check that the login link reappears
		assert_select "a[href=?]", login_path
		# Check that the logout link disappears
		assert_select "a[href=?]", logout_path,      count: 0
		# Check that the profile link disappears
		assert_select "a[href=?]", user_path(@user), count: 0
	end

end
