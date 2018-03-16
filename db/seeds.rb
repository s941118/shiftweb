10.times do
	@p = Post.create({
		number: Post.all.size + 1,
		title: "post#{rand(1..10)}",
		category: "shift"
	})
	@p.contents.create({
		html: "<p>As much we admire the explorers traveling to the ends of the Earth on large scale Expeditons it’s the everyday man (or women) exploring their own backyard that often inspire the most. Guys like Chris Dahl-Bredine, who built an experimental aircraft in his garage in order to bring a new perspective to his life & creative vision. There isn’t much glamour in this type of exploration. No sponsors footing the bill. Just hard work, cold mornings & sometimes a bit of duct tape. Part cowboy, part photographer, part mechanic, Chris' work blends a blue collar work ethic with a special eye for landscapes and the interconnectedness of it all.</p>",
		ordering: @p.contents.size
	})
end

10.times do
	Tag.create({
		name: "test#{rand(100..999)}",
	})
end
20.times do
	Tag.create({
		name: "test#{rand(100..999)}",
	})
end