module PostsHelper
	def render_post_status(post)
		status = I18n.t("activerecord.post_status.#{post.status}")
		if post.draft?
			"<span class='badge badge-light'>#{status}</span>"
		elsif post.publish?
			"<span class='badge badge-success'>#{status}</span>"
		end.html_safe
	end
end