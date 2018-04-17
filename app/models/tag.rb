class Tag < ApplicationRecord
	validates :name, presence: true, uniqueness: true
	has_many :work_tags, inverse_of: :tag, dependent: :destroy
	has_many :works, through: :work_tags
	has_one_attached :icon
	attr_accessor :remove_icon
	has_one_attached :member_bg
	attr_accessor :remove_member_bg
	scope :shift, -> { where(category: "SHIFT") }
	scope :cooperation, -> { where(category: "COOPERATION") }
	scope :unused, -> { where(works_count: 0) }
	scope :member, -> { where.not(job_title: "").where.not(join_time: "") }

	# 以下為幫助產生對應 html
	def icon_or_default
		icon.attached? ? icon : "http://via.placeholder.com/350x450/333.jpg"
	end
	def member_bg_or_default
		member_bg.attached? ? member_bg : "http://via.placeholder.com/350x450/333.jpg"
	end
	# 以上為幫助產生對應 html

	def member?
		job_title.present? || join_time.present?
	end

	def unused?
		works_count == 0
	end
end
