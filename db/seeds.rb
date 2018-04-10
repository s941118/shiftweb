10.times do
	@p = Work.create({
		number: Work.all.size + 1,
		title: "Rise from Music",
		category: "SHIFT",
		status: "publish"
	})
	@p.contents.create({
		html: '<p>#20' + rand(10..99).to_s + '</p>
<p class="paragraph-title"></p><p>CLIENT&nbsp; &nbsp;<a href="http://www.google.com.tw">中央大學科學教育中心</a><br>
SERVICE&nbsp; 視覺識別策劃 VI Strategy | 使用介面規劃 UI design</p>
<p class="p-break paragraph-title">BRIEF</p>
<p>「台灣科學教育領域中,主要關注 #K-12 孩童科學教育發展的中央大學科學教育中心,過去一直以台灣老氣的品牌形象呈現在孩童前,為了一改整體風格形象,中大科教決定以全新且整體的視覺來帶給學生們更多學習科學的動機。</p>
<p class="p-break paragraph-title">SOLUTION</p>
<p>這次設計專案視覺主要傳達親近和諧的感覺，為了貼近K-12年齡層的學生，我們團隊最終決定藉著吉祥物「 #科科 」去作為溝通與行銷的媒介，為了象徵性的代表六大活動的視覺，科科被設計在六種不同的活動情境，利用不同物件呈現從戶外主題活動到實驗室演示實驗的情境，成功地拉近親子與品牌間的距離，孩童們更主動的喜愛上科學，這正是利用視覺傳達成功解決問題與優化方法的案例。</p>',
		ordering: @p.contents.size,
	})
end

Work.all.each { |w| w.update_tags! }

Tag.all.each { |tag| tag.update(category: "SHIFT") }
5.times { Tag.find(rand(1..Tag.all.size)).update(category: "COOPERATION") }