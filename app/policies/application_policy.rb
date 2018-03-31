class ApplicationPolicy
  attr_reader :user, :record

	def initialize(user, record)
    @user = user
    if record.is_a? Array
      @parent = record.first
      @record = record.last
    else
      @record = record
    end
  end
end
