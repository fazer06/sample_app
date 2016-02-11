# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string
#  email           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#

class User < ActiveRecord::Base
	# downcase the email and username attributes before saving the user
	before_save { self.email = email.downcase }
	before_save { self.username = username.downcase }
	# Validates that :username is present and not over 50 characters long, and is unique.
	validates :username, presence: true, length: { maximum: 50 },
		# Test for case_sensitive and uniqueness. 
		# Rails infers that uniqueness should be true as well 
		uniqueness: { case_sensitive: false }
	# Only email addresses that match the pattern will be considered valid
 	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
 	# Validates that :email is present and not over 255 characters long, 
	validates :email, presence: true, length: { maximum: 255 },
		# uses regex pattern matching, and is unique.
		format: { with: VALID_EMAIL_REGEX },
		# Test for case_sensitive and uniqueness. 
		# Rails infers that uniqueness should be true as well 
		uniqueness: { case_sensitive: false }
		has_secure_password
		# The password should be present and have a minimum length, and allow nil
		# for updating the profile
		validates :password, presence: true, length: { minimum: 6 }
end
