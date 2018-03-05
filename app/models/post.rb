class Post < ApplicationRecord
	has_many :contents, dependent: :destroy, inverse_of: :post

	validates :title, presence: { message: "不可空白" }

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
		"https://images.unsplash.com/photo-1431629452562-165c8f49fc97?ixlib=rb-0.3.5&s=995930e5e5a391860e70cd6bd781546c&auto=format&fit=crop&w=1350&q=80"
		# self.attachments.cover
	end
	# 以上為幫助產生對應 html
end