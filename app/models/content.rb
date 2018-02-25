class Content < ApplicationRecord
  belongs_to :portfolio, inverse_of: :contents
  validates_presence_of :portfolio
  validates :html, :ordering, presence: true

  # 以下為協助資料維護相關
    before_save :remove_fb_data_width

    def remove_fb_data_width
    	self.html = self.html.gsub(/data-width="[0-9]+/,"data-width=''")
    end
  # 以上為協助資料維護相關

  # 以下為幫助產生對應 html
    def conditional_klass
    	embed? ? embed_html_klass : (wrapper_klass.present? ? wrapper_klass : Content.default_wrapper_klass)
    end

    def embed_html_klass(type = nil)
      if self.instagram? || type == "instagram"
        "offset-md-3 col-md-6 text-center embed_content"
      else
        "offset-md-2 col-md-8 text-center embed_content #{'facebook' if self.facebook?}"
      end
    end

    def self.default_wrapper_klass
    	"col-md-12"
    end

    def embed?
    	iframe? || instagram? || facebook?
    end

    def iframe?
      html.to_s[/iframe/].present?
    end

    def instagram?
      html.to_s[/www\.instagram\.com\/embed\.js/].present?
    end

    def facebook?
    	html.to_s[/fb-/].present?
    end
  # 以上為幫助產生對應 html
end
