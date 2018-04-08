module WorksHelper
	def render_work_status(work)
		status = I18n.t("activerecord.work_status.#{work.status}")
		if work.draft?
			"<span class='badge badge-light'>#{status}</span>"
		elsif work.publish?
			"<span class='badge badge-success'>#{status}</span>"
		end.html_safe
	end
end