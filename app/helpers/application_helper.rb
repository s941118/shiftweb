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

  def render_og_image
    if action_name == "works"
      "https://shift-static-assets.s3-accelerate.amazonaws.com/works.png"
    elsif action_name.in? ["contact", "about", "home", "members"]
      root_url[0..-2] + asset_path("#{action_name}.jpg")
    elsif controller_name == "works"
      @work.present? && @work.cover.attached? ? root_url[0..-2] + url_for(@work.og_image) : root_url[0..-2] + asset_path('error.png')
    else
      root_url[0..-2] + asset_path("error.png")
    end
  end
end