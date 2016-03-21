require 'test_helper'

class MicropostsControllerTest < ActionController::TestCase

	def setup
		@micropost = microposts(:spin)
	end

	test "should redirect create when not logged in" do
		# Confirm that the micropost count is unchanged
		assert_no_difference 'Micropost.count' do
			post :create, micropost: { content: "Lorem ipsum" }
		end
		assert_redirected_to login_url
	end

	test "should redirect destroy when not logged in" do
		# Confirm that the micropost count is unchanged
		assert_no_difference 'Micropost.count' do
			delete :destroy, id: @micropost
		end
		assert_redirected_to login_url
	end

	# Redirect destroy for wrong trying to delete a micropost
	test "should redirect destroy for wrong micropost" do
		# Log in as the user fazer
		log_in_as(users(:fazer))
		# Try to delete the micropost called liveanotherday in the fixtures
		# micropost.yml that was made by the user renee
		micropost = microposts(:liveanotherday)
		# Make sure there is no difference in the database
		assert_no_difference 'Micropost.count' do
			delete :destroy, id: micropost
		end
		# redirect to root
		assert_redirected_to root_url
	end

end
