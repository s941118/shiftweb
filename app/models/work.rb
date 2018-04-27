class Work < ApplicationRecord
	enum status: { draft: 0, publish: 1 }

	validates :title, presence: { message: "請先填寫標題，之後可以隨時修改唷～" }

	has_many :contents, dependent: :destroy, inverse_of: :work
	has_many :work_tags, dependent: :destroy, inverse_of: :work
	has_many :tags, through: :work_tags

	has_one_attached :cover
	attr_accessor :remove_cover

	def self.x(n)
		n ||= self.all.size
		least_sqrt = Math.sqrt(n.to_f).to_i
		all_size = n.to_f
		if all_size + least_sqrt >= (least_sqrt + 1)**2
			return least_sqrt + 1
		elsif all_size > least_sqrt**2 - least_sqrt
			return least_sqrt
		else
			n.to_i
		end
	end

	def update_tags!
		tags_text = []
		self.contents.text.each do |content|
			# content.update_column(:processed_html, content.html.gsub(/(?:#([^\s,\.,\<\/[:space:]]+))/,'<a href="/works?tag=\1">#\1</a>'))
			all_text_in_content_html = Nokogiri::HTML(content.html).xpath("//text()").to_s.strip
			tags_in_this_content = all_text_in_content_html.scan(/(?:#([^\s,\.,\<\/[:space:]]+))/).flatten #Nokogiri.parse(content.html).text.scan(/(?:#([^\s,\.]+))/).flatten
			processing_html = content.html
			tags_in_this_content.each do |tag_name|
				m = processing_html.match(/(##{tag_name})/)[1].gsub(/^#/,"")
				processing_html = processing_html.gsub(/(##{tag_name})/, "<a href='/works?tag=#{m}'>##{m}</a>")
			end
			content.update_column(:processed_html, processing_html)
			tags_text << tags_in_this_content
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
	after_commit :clean_tags!

	def clean_tags!
		Tag.unused.each do |tag|
			unless tag.member?
				tag.destroy
			end
		end
	end

	after_touch :update_ordering

	def update_ordering
  	self.contents.order(ordering: :asc).each_with_index do |content, index|
  		content.update_column(:ordering, index)
  	end
  end

  after_create :set_default_work_date!

  def set_default_work_date!
  	self.update_column(:work_date, self.created_at) unless self.work_date.present?
  end
  # 以上為協助資料維護相關

  # 以下為幫助產生對應 html
	def cover_or_default
		cover.attached? ? cover.variant(resize: Content.resize_string) : "http://via.placeholder.com/1400x788/333.jpg"
	end

	def cover_thumbnail_or_default
		cover.attached? ? cover.variant(resize: Content.resize_string("thumbnail")) : "http://via.placeholder.com/1400x788/333.jpg"
	end
	# 以上為幫助產生對應 html
end