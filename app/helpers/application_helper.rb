module ApplicationHelper
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		session.has_key? :user_id
	end

	def flash_class(level)
	    case level
	        when "success" then "alert alert-success"
	        when "error" then "alert alert-danger"
	        when "info" then "alert alert-info"
	        when "warning" then "alert alert-warning"
	    end
	end
end
