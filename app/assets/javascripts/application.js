//= require foundation.min
//= require barba.min
//= require anime.min
//= require jquery.kinetic.min
//= require app
Barba.Dispatcher.on('transitionCompleted', function(currentStatus, oldStatus) {
	var work_id_match = window.location.href.match(/works\/(\d+)/)
  if (work_id_match !== null && work_id_match[1] > 0) {
  	console.log("loading work" + work_id_match[1])
    $(".work-block[data-work-id='" + work_id_match[1] + "']").trigger("click")
  }
});