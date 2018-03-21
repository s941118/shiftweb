$(document).on("change", "input#tag_icon", function(e) {
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