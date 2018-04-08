class Admin::WorkPolicy < AdminPolicy
	def publish?
		update? && record.draft?
	end

	def draft?
		update? && record.publish?
	end
end