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
#  remember_digest :string
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#

class User < ActiveRecord::Base

	attr_accessor :remember_token
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

	# Returns the hash digest of the given string.
 	# User.digest(string) is the clearest way to define it
 	# but it can be written as self.digest(string)
 	# it's used for minimum cost in the tests,
 	# and it is called from test/fixtures/users.yml
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
													  BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	############### Create the remember token and remember digest ##############

	# With these two methods we've created a valid token and associated digest 
	# by first making a new remember token using User.new_token, 
	# and then updating the remember digest with the result of applying User.digest.

	# We need to create a random string of digits for use as a remember token.
	# This returns a random token for use in the remember method below
	# User.new_token is the clearest way to define it
 	# but it can be written as self.new_token 
  	def User.new_token
		SecureRandom.urlsafe_base64
	end

	# Remembers a user in the database for use in persistent sessions.
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	############################################################################

	# Returns true if the given token matches the digest.
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	# Forgets a user.
	def forget
		update_attribute(:remember_digest, nil)
	end



end