// 參考用法
// <%= f.file_field :icon, class: "d-none previewable" %>
// <%= image_tag tag.icon_or_default, style: "max-width: 100%;", id: "previewer", data: { file: "input#tag_icon" } %>

$(document).on("click", "img#previewer", function(e) {
	var target = this.getAttribute("data-file")
	document.querySelector(target).click()
})

$(document).on("change", "input[type='file'].previewable", function(e) {
	previewFile(document.querySelector("#previewer"), this)
})

function previewFile(previewer, file_input){
	var file    = file_input.files[0]; //sames as here
	var reader  = new FileReader();

	reader.onloadend = function () {
	  previewer.src = reader.result;
	}

	if (file) {
	  reader.readAsDataURL(file); //reads the data as a URL
	} else {
	  previewer.src = "";
	}
}