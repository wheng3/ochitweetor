class User < ApplicationRecord
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
end