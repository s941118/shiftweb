class Admin::PostPolicy < AdminPolicy
	def publish?
		update? && record.draft?
	end
end