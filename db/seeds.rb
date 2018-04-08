10.times do
	@p = Work.create({
		number: Work.all.size + 1,
		title: "Work#{rand(1..10)}",
		category: "shift"
	})
	@p.contents.create({
		html: "<p>這次設計專案視覺主要傳達親近和諧的感覺，為了貼近K-12年齡層的學生，我們團隊最終決定藉著吉祥物「科科」去作為溝通與行銷的媒介，為了象徵性的代表六大活動的視覺，科科被設計在六種不同的活動情境，利用不同物件呈現從戶外主題活動到實驗室演示實驗的情境，成功地拉近親子與品牌間的距離，孩童們更主動的喜愛上科學，這正是利用視覺傳達成功解決問題與優化方法的案例。</p>",
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