class PostPolicy < ApplicationPolicy
	def index?
		true
	end

	def new?
		user.present?
	end

	def create?
		user.present?
	end

	def edit?
		update?
	end

	def show?
		true
	end

	def update?
		user.present? && record.present?
	end

	def publish?
		update? && record.draft?
	end

	def draft?
		update? && record.publish?
	end	
end