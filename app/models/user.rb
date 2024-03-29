# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#
require 'digest'

class User < ActiveRecord::Base
    # Defines that the columns can be modified
	attr_accessor :password
	attr_accessible :name, :email, :password, :password_confirmation
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	
	# Validates in Presence: Name cannot be blank
	validates :name, :presence => true,
					 :length => { :maximum => 50 }
	validates :email, :presence => true,
					  :format   => { :with => email_regex },
					  :uniqueness => { :case_sensitive => false }
	validates :password, :presence => true,
						 :confirmation => true,
						 :length => { :within => 6..40 }
	
    # Active Record calls this method before save	
	before_save :encrypt_password
	
	# Return true if the user's password matches the submitted password.
    def has_password?(submitted_password)
		# Compare encrypted_password with the encrypted version of
		# submitted_password.
		encrypted_password == encrypt(submitted_password)
    end

	# Authenticating a user
	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil  if user.nil?
		return user if user.has_password?(submitted_password)
	end

	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
	end


    private

	# Before save this method will get call to encrypt password
    def encrypt_password
	  # Ensures that salt gets reset whenever user changes its password.
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

					 

	
end
