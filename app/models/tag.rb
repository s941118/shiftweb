class Tag < ApplicationRecord
	validates :name, presence: true, uniqueness: true
	has_many :post_tags, inverse_of: :tag, dependent: :destroy
	has_many :posts, through: :post_tags
	has_one_attached :icon
	# scope :shift, -> { where(category: "shift") }
	# scope :cooperation, -> { where(category: "cooperation") }

	# 以下為幫助產生對應 html
	def icon_or_default
		icon.attached? ? icon : "http://via.placeholder.com/219x158/333.jpg"
	end
	# 以上為幫助產生對應 html
end
