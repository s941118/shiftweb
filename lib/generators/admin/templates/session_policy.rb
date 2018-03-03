class SessionPolicy < <%= options[:namespace].camelize %>Policy
	def new
		true
	end

	def create
		true
	end

	def destroy
		user.present?
	end
end