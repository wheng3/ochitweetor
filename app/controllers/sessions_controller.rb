class SessionsController < ApplicationController
	def create
		if current_user
			# current_user.update_token
		else
			auth = request.env["omniauth.auth"]
			if auth
				user = User.from_omniauth(auth)
				session[:user_id] = user.id
				flash[:success] = "Welcome, #{user.name}"
			else
				user =  User.find_by(email: params[:session][:email]).try(:authenticate, params[:session][:password])
				if user
					session[:user_id] = user.id
					flash[:success] = "Welcome, #{user.name}"
				else
					flash[:error] = "Failed to login"
				end
			end
		end
		redirect_to root_path
	end

	def destroy
		session.clear
		flash[:success] = "See you again!"
		redirect_to root_path
	end
end