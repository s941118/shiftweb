class Post < ApplicationRecord
	has_many :contents, dependent: :destroy, inverse_of: :post, dependent: :destroy
	has_many :post_tags, inverse_of: :post, dependent: :destroy
	has_many :tags, through: :post_tags

	after_commit :clean_tags

	def update_tags!
		tags_text = []
		self.contents.text.each do |content|
			tags_in_this_content = CGI.unescapeHTML(content.html).scan(/(?:#(\w+))/).flatten
			tags_text << tags_in_this_content
			content.update_column(:processed_html, CGI.unescapeHTML(content.html).gsub(/(?:#(\w+))/,'<a href="/tags/\1">#\1</a>'))
		end
		tags_text = tags_text.flatten.uniq
		self.tag_list = tags_text
		self.top_tags = tags_text[0..2].join(",")
		self.save
	end

	def clean_tags
		Tag.where(posts_count: 0).destroy_all
	end

	def self.tagged_with(name)
	  Tag.find_by_name!(name).posts
	end

	def self.tag_counts
	  Tag.select("tags.*, count(post_tags.tag_id) as count").
	    joins(:post_tags).group("post_tags.tag_id")
	end

	def tag_list
	  tags.pluck(:name)
	end

	def tag_list=(names)
		self.tags = names.reject(&:empty?).map do |n|
	    Tag.where(name: n.strip).first_or_create
	  end
	end

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