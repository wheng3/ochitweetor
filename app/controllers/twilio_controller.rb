class TwilioController < ApplicationController
	skip_before_action :verify_authenticity_token

	def sms
	    message_body = params["Body"]
	    from_number = params["From"]

	    twitter_client.update(message_body)

	    twilio_client.messages.create(
	      from: ENV["TWILIO_PHONE_NUMBER"],
	      to: from_number,
	      body: "Hello there, thanks for tweeting with Ochi Tweetor! Your number is #{from_number}. Your tweet has been posted!"
	    )
	end

	private

		def twilio_client
			@twilio_client = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
		end

		def twitter_client
			@twitter_client ||= Twitter::REST::Client.new do |config|
				config.consumer_key        = ENV["TWITTER_API_KEY"]
				config.consumer_secret     = ENV["TWITTER_API_SECRET"]
				config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
				config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
			end
		end
end
