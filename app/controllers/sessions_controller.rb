class SessionsController < ApplicationController
	def create
		if current_user
			# current_user.update_token
		else
			auth = request.env["omniauth.auth"]
			user = User.from_omniauth(auth)
			session[:user_id] = user.id
		end
		flash[:success] = "Welcome, #{user.name}"
		redirect_to root_path
	end

	def destroy
		session.clear
		flash[:success] = "See you again!"
		redirect_to root_path
	end
end