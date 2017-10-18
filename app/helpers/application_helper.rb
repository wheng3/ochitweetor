module ApplicationHelper
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		session.has_key? :user_id
	end
end
