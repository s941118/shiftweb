class Work < ApplicationRecord
	enum status: { draft: 0, publish: 1 }

	validates :title, presence: { message: "請先填寫標題，之後可以隨時修改唷～" }

	has_many :contents, dependent: :destroy, inverse_of: :work
	has_many :work_tags, dependent: :destroy, inverse_of: :work
	has_many :tags, through: :work_tags

	has_one_attached :cover
	attr_accessor :remove_cover

	def update_tags!
		tags_text = []
		self.contents.text.each do |content|
			tags_in_this_content = Nokogiri.parse(content.html).text.scan(/(?:#([^\s,\.]+))/).flatten
			tags_text << tags_in_this_content
			content.update_column(:processed_html, Nokogiri.parse(content.html).text.gsub(/(?:#([^\s,\.]+))/,'<a href="/tags/\1">#\1</a>'))
		end
		tags_text = tags_text.flatten.uniq
		self.tag_list = tags_text
		self.top_tags = tags_text[0..2].join(",")
		self.save
	end

	def top_tags_string
		if top_tags.to_s.present?
			top_tags_arr = top_tags.to_s.split(",")
			result = top_tags_arr.map { |text| "##{text}" }.join(", ")
			return tags_count > 3 ? result + " ..." : result
		else
			""
		end
	end

	def self.tagged_with(name)
	  Tag.find_by_name!(name).works
	end

	def self.tag_counts
	  Tag.select("tags.*, count(work_tags.tag_id) as count").
	    joins(:work_tags).group("work_tags.tag_id")
	end

	def tag_list
	  tags.pluck(:name)
	end

	def tag_list=(names)
		self.tags = names.reject(&:empty?).map do |n|
	    Tag.where(name: n.strip).first_or_create
	  end
	end

	accepts_nested_attributes_for :contents, allow_destroy: true, reject_if: proc { |attributes| attributes['html'].blank? || attributes['ordering'].blank? }

	# 以下為協助資料維護相關
	after_commit :clean_tags

	def clean_tags
		Tag.where(works_count: 0).destroy_all
	end

	after_touch :update_ordering

	def update_ordering
  	self.contents.order(ordering: :asc).each_with_index do |content, index|
  		content.update_column(:ordering, index)
  	end
  end
  # 以上為協助資料維護相關

  # 以下為幫助產生對應 html
	def cover_or_default
		cover.attached? ? cover : "http://via.placeholder.com/1400x788/333.jpg"
	end
	# 以上為幫助產生對應 html
end