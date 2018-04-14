module ApplicationHelper
	def meta_title
    @page_title.present? ? "#{@page_title} | SHIFT" : "SHIFT studio"
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