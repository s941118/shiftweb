class WorkPolicy < ApplicationPolicy
	def index?
		true
	end

	def show?
		record.present? && record.publish?
	end	
end