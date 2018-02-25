module ApplicationHelper
	def meta_title
    @page_title.present? ? "#{@page_title} | 鴻妍搏命" : "鴻妍搏命工作室"
  end

	def notice_message(opts = {})
    if flash.any?
      flash.map do |type, message|
        content_tag :div, class:"alert alert-#{type}", role:"alert" do
          content_tag :strong, type.capitalize
          message
        end
      end[0]
    end
  end
end