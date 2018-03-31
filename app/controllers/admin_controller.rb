class AdminController < ApplicationController
	before_action :authenticate_user!
	layout "admin"

	def authenticate_user!
		unless user_signed_in?
			redirect_to root_url 
		end
	end
end