10.times do
	@p = Work.create({
		number: Work.all.size + 1,
		title: "Work#{rand(1..10)}",
		category: "shift"
	})
	@p.contents.create({
		html: "<p>Good Lord, it's massive. My biggest question is why? You realize that all modern languages have XML parsers, right? You can do all that in like 3 lines and be sure it'll work. Furthermore, do you also realize that pure regex is provably unable to do certain things? Unless you've created a hybrid regex/imperative code parser, but it doesn't look like you have. Can you compress random data as well?</p>",
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