class Admin::PostPolicy < AdminPolicy
	def publish?
		update? && record.draft?
	end

	def draft?
		update? && record.publish?
	end
end