class SessionsController < ApplicationController
	def create
		if current_user
			# current_user.update_token
		else
			auth_hash = request.env["omniauth.auth"]
			user = User.from_omniauth(auth_hash)
			session[:user_id] = user.id
		end
		flash[:success] = "Welcome, #{user.name}"
	end

	def destroy
		session.clear
		flash[:success] = "Goodbye!"
		redirect_to root_path
	end
end