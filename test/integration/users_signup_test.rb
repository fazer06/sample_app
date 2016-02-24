require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	# Invalid Signup
	test "invalid signup information" do
	  # Visit the signup page
      get signup_path
      # Make sure there is no difference to the User model
      assert_no_difference 'User.count' do
      # Issue a post request with invalid signup information
      post users_path, user: { username:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    	end
    	# check the user’s new action is re-rendered
    	assert_template 'users/new'
    	# check the error explanation div is on the page
      	assert_select 'div#error_explanation'
      	# check the field_with_errors div is on the page
      	assert_select 'div.field_with_errors'
  	end

    # Valid signup
    test "valid signup information" do
      # Visit the signup page
      get signup_path
      # Make sure the User count has increased by 1
      assert_difference 'User.count', 1 do
      # Post with valid signup information
      post_via_redirect users_path, user: { username:   "jo", 
                                            email:      "jo@example.com",
                                            password:   "password",
                                            password_confirmation: "password" }
      end
        # check the user’s profile page loads from the show action
        assert_template 'users/show'
    end

end
