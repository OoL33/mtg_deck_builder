class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

	before_action :authenticate_user!

	def after_sign_in_path_for(resource)
		# rails routes - path helpers
		"/users/#{current_user.id}"
	end
end
