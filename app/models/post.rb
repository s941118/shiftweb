class Post < ApplicationRecord
	has_many :attachments, dependent: :destroy
	has_many :contents, dependent: :destroy, inverse_of: :portfolio

	accepts_nested_attributes_for :contents, allow_destroy: true, reject_if: proc { |attributes| attributes['html'].blank? || attributes['ordering'].blank? }

	# 以下為協助資料維護相關
		after_touch :update_ordering

		def update_ordering
	  	self.contents.order(ordering: :asc).each_with_index do |content, index|
	  		content.update_column(:ordering, index)
	  	end
	  end
  # 以上為協助資料維護相關

  # 以下為幫助產生對應 html
		def cover
			"https://picsum.photos/200/200"
		end
	# 以上為幫助產生對應 html
end