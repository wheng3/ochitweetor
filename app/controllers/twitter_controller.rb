class TwitterController < ApplicationController

	def follow_back
		if current_user
			if !current_user.provider.nil?
				@follow_back = []
				@twitter_client = twitter_client
				friends = @twitter_client.friends
				followers = @twitter_client.followers
				following_requested = @twitter_client.friendships_outgoing
				followers.each do |follower|
					if !friends.include?(follower)
						if !following_requested.include?(follower.id)
							@twitter_client.follow(follower.id)
							@follow_back << follower
						end
					end
				end
				flash[:success] = "Followed back all your followers"
			else
				flash[:error] = "Sorry, the follow back feature is not available to non-twitter account"
			end
		else
			flash[:error] = "Please login with your twitter account to enable the follow back feature "
		end
		redirect_to root_path
	end

	def search
		if params[:search]
			@twitter_client = twitter_client
			@tweets = @twitter_client.search(params[:search], result_type: "popular").take(10)
			@tweets_oembeds = @twitter_client.oembeds(@tweets)
			respond_to do |format|
				format.html { redirect_to root_path,  flash: {success: "Successfully found 10 of the most popular tweets about #{params[:search]}"} }
				format.js
			end
		else
			respond_to do |format|
				format.html { redirect_to root_path,  flash: {error: "Failed to search, please try again by putting keyword"} }
				format.js
			end
		end
	end

	private

		def twitter_client
			@twitter_client ||= Twitter::REST::Client.new do |config|
				config.consumer_key        = ENV["TWITTER_API_KEY"]
				config.consumer_secret     = ENV["TWITTER_API_SECRET"]
				config.access_token        = current_user.token
				config.access_token_secret = current_user.secret
			end
		end
end