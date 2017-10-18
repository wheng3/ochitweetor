class User < ApplicationRecord
	#Validations
	validates :name, presence: true
	validates :email, presence: true,
					  uniqueness: {message: 'Email has already been registered, try a different one'},
					  if: :email_required?
	validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/, 
								if: :email_required?
	has_secure_password validations: false, if: :password_required?
	validates :password, presence: {message: 'Password cannot be blank'},
						 length: {within: 8..20, message: 'Password length must be between 8 to 20'},
						 if: :password_required?

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.name = auth.info.name
			user.location = auth.info.location
			user.image = auth.info.image
			user.twitter = auth.info.urls.Twitter
			user.token = auth.credentials.token
			user.secret = auth.credentials.secret
			user.save!
			return user
		end
	end

	def email_required?
		provider.blank? 
	end

	def password_required?
		provider.blank?
	end
end