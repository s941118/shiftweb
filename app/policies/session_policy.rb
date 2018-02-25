class SessionPolicy < ApplicationPolicy
	def new
		true
	end

	def create
		true
	end

	def destroy
		@user.present?
	end
end