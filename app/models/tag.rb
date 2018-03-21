class Tag < ApplicationRecord
	validates :name, presence: true, uniqueness: true
	has_many :post_tags, inverse_of: :tag, dependent: :destroy
	has_many :posts, through: :post_tags
	has_one_attached :icon
	# scope :shift, -> { where(category: "shift") }
	# scope :cooperation, -> { where(category: "cooperation") }
end
