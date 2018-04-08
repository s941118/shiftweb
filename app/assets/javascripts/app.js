var Home = Barba.BaseView.extend({
    namespace: "home",
    onEnter: function () {},
    onEnterCompleted: function () {
        initHome();
    },
    onLeave: function () {},
    onLeaveCompleted: function () {
    	$('.menu-button').removeClass('close');
		$('.mobile-nav').removeClass('mobile-nav-open', 300);
    }
});
var Works = Barba.BaseView.extend({
    namespace: "works",
    onEnter: function () {},
    onEnterCompleted: function () {
        initWorks();
    },
    onLeave: function () {},
    onLeaveCompleted: function () {
    	$('.menu-button').removeClass('close');
		$('.mobile-nav').removeClass('mobile-nav-open', 300);
    }
});
var Members = Barba.BaseView.extend({
    namespace: "members",
    onEnter: function () {},
    onEnterCompleted: function () {
        initMembers();
    },
    onLeave: function () {},
    onLeaveCompleted: function () {
    	$('.menu-button').removeClass('close');
		$('.mobile-nav').removeClass('mobile-nav-open', 300);
    }
});
var Contact = Barba.BaseView.extend({
    namespace: "contact",
    onEnter: function () {},
    onEnterCompleted: function () {
        initContact();
    },
    onLeave: function () {},
    onLeaveCompleted: function () {
    	$('.menu-button').removeClass('close');
		$('.mobile-nav').removeClass('mobile-nav-open', 300);
    }
});
function queue(start) {
	var rest = [].splice.call(arguments, 1),
	promise = $.Deferred();

	if (start) {
		$.when(start()).then(function () {
		    queue.apply(window, rest);
	});
} else {
	promise.resolve();
}
	return promise;
}
function preloaderTimeline() {
	$(window).load(function(){
		var dUp = document.querySelector('.loader-bottom');
	    var dDown = document.querySelector('.loader-top');
	    var loadUp = anime({
		  targets: dUp,
		  height: '0%',
		  easing: 'easeInQuart',
		  duration: 1000,
		});
		var loadDown = anime({
		  targets: dDown,
		  height: '0%',
		  easing: 'easeInQuart',
		  duration: 1000,
		});
	});
}
$(function () {
	Home.init();
	Works.init();
	Members.init();
	Contact.init();
	preloaderTimeline();
	Barba.Pjax.init();
    Barba.Prefetch.init();
    var FadeTransition = Barba.BaseTransition.extend({
	  start: function() {
	    Promise
	      .all([this.newContainerLoading, this.fadeOut()])
	      .then(this.fadeIn.bind(this));
	  },

	  fadeOut: function() {
	    return new Promise(function(resolve){
		    var dDown = document.querySelector('.loader-top');
		    anime({
			  targets: dDown,
			  height: '50%',
			  easing: 'easeInQuart',
			  duration: 1000,
			  complete: function(){
			  	resolve()
			  }
			});
			var dUp = document.querySelector('.loader-bottom');
		    anime({
			  targets: dUp,
			  height: '50%',
			  easing: 'easeInQuart',
			  duration: 1000,
			  complete: function(){
			  	resolve()
			  }
			});
	    })
	  },

	  fadeIn: function() {
	    
	    var _this = this;
	    var $el = $(this.newContainer);
	    window.scrollTo(0,0)
	    $(this.oldContainer).hide();
	    var dDown = document.querySelector('.loader-bottom');
	    var dUp = document.querySelector('.loader-top');
	    anime({
		  targets: dDown,
		  height: '0%',
		  easing: 'easeInQuart',
		  duration: 1000,
		});
		anime({
		  targets: dUp,
		  height: '0%',
		  easing: 'easeInQuart',
		  duration: 1000,
		  complete: function(){
		  	$('.content').removeClass('content-loading');
		  	_this.done();
		  }
		});

	  }
	});
    Barba.Pjax.getTransition = function() {
 		return FadeTransition;
	};
	
	Barba.Pjax.cacheEnabled = false;

});

function initGlobal() {
	$(window).load(function(){
		$('.content').removeClass('content-loading');
	});
	$(document).foundation();
	$('.menu-button').click(function(e) {
		var open = $(this).hasClass('close');
		if(!open) {
			$(this).addClass('close');
			$('.mobile-nav').addClass('mobile-nav-open', 300);
		} else {
			$(this).removeClass('close');
			$('.mobile-nav').removeClass('mobile-nav-open', 300);
		}
	});
	$(".nav-menu ul li a").each(function() {
		var linkAttr = $(this).attr("data-name");
		var contentAttr = $(".content").attr("data-namespace");
		if(linkAttr == contentAttr) {
			$(this).addClass('has-link');
		} else {
			$(this).removeClass('has-link');
		}
		if(contentAttr == 'works') {
			$(".nav-menu ul").addClass('works-nav');
		} else if(contentAttr == 'members') {
			$(".nav-menu ul").addClass('works-nav');
		} else if(contentAttr == 'contact') {
			$(".nav-menu ul").addClass('works-nav');
		} else {
			$(".nav-menu ul").removeClass('works-nav');
		}
	});
	$('.lines-button').click(function(e) {
		e.preventDefault();
		$('.lines-button').toggleClass('close');
		$('.social-menu').toggleClass('social-menu-open', 300);
	});
	$(".chat-box").click(function(e){
		e.stopPropagation();
		$(this).removeClass('chat-box-pulse');
		$(".chat-box img").addClass('chat-img-open');
		queue(function(){
			return $(".chat-box").stop().animate({width: '320'});
		}, function(){
			return $(".chat-box").stop().animate({height: '320'});
		});
	});
	$(document).click(function(){
		$(".chat-box img").removeClass('chat-img-open');
		queue(function(){
			return $(".chat-box").stop().animate({height: '60'});
		}, function(){
			return $(".chat-box").stop().animate({width: '60'});
		}, function(){
			$(".chat-box").addClass('chat-box-pulse');
		});
	});
}

function initHome() {
	initGlobal();
	$('.new-work-box').click(function(){
		$(".new-work-wrap").toggleClass('new-work-wrap-open');
		$(".new-work-button").toggleClass('new-work-button-open');
		$(this).toggleClass('new-work-box-open');
	});
}
function initWorks() {
	initGlobal();
	var lisInRow = 0;
	function filterTop(top) {
		return function(i) {
			return $(this).offset().top == top;
		};
	}
	setTimeout(function(){
		$('.works-nav').removeClass('work-nav-hide');
	}, 1000);
	setTimeout(function(){
		$('.work-block').removeClass('work-block-hide');
	}, 1200);
	var el = $('.work-block:first');
	var elWidth = el.outerWidth(true);
	var mapSize = (Math.round(Math.sqrt($('.work-block').length)) + 2);
	var wHeight = $(window).innerHeight();
	var outerBorder = $('.content').outerHeight() - $('.content').height();
	var innerBorder = $('.works-map-wrapper').outerHeight() - $('.works-map-wrapper').height();
	var areaHeight = wHeight - outerBorder - innerBorder;
	var windowRatio = $(window).innerWidth() - 245;
	var previewInnerW = ($(window).innerWidth() - 245) / $('.preview-wrapper').innerWidth();
	$('.works-map').width((elWidth * mapSize) + 100);
	
	$('.works-content').kinetic();
	$('.works-map').mouseout(function(){
		$('.works-map-wrapper').kinetic('detach');
	});
	$('.works-map').mouseover(function(){
		$('.works-map-wrapper').kinetic('attach');
	});
	$('.works-map').mousemove(function(){
		if(($('.preview-wrapper').offset().top) > 0) {
			$('.map-more-top').fadeOut();
		} else {
			$('.map-more-top').fadeIn();
		}
		if(($('.preview-wrapper').offset().left) > 0) {
			$('.map-more-left').fadeOut();
		} else {
			$('.map-more-left').fadeIn();
		}
		if($('.preview-wrapper').offset().top + $('.preview-wrapper').height() < $(window).innerHeight()) {
			$('.map-more-down').fadeOut();
		} else {
			$('.map-more-down').fadeIn();
		}
		if($('.preview-wrapper').offset().left + $('.preview-wrapper').width() < $(window).innerWidth()) {
			$('.map-more-right').fadeOut();
		} else {
			$('.map-more-right').fadeIn();
		}
	});
	$(document).scroll(function(){
		if(($('.preview-wrapper').offset().top) > 0) {
			$('.map-more-top').fadeOut();
		} else {
			$('.map-more-top').fadeIn();
		}
		if(($('.preview-wrapper').offset().left) > 0) {
			$('.map-more-left').fadeOut();
		} else {
			$('.map-more-left').fadeIn();
		}
		if($('.preview-wrapper').offset().top + $('.preview-wrapper').height() < $(window).innerHeight()) {
			$('.map-more-down').fadeOut();
		} else {
			$('.map-more-down').fadeIn();
		}
		if($('.preview-wrapper').offset().left + $('.preview-wrapper').width() < $(window).innerWidth()) {
			$('.map-more-right').fadeOut();
		} else {
			$('.map-more-right').fadeIn();
		}
	});
	$('.map-more-top').mousedown(function(){
		$('.works-map-wrapper').kinetic('start', {velocityY: -10 });
	}).mouseup(function(){
		$('.works-map-wrapper').kinetic('stop');
	});
	$('.map-more-down').mousedown(function(){
		$('.works-map-wrapper').kinetic('start', {velocityY: 10 });
	}).mouseup(function(){
		$('.works-map-wrapper').kinetic('stop');
	});
	$('.map-more-left').mousedown(function(){
		$('.works-map-wrapper').kinetic('start', {velocity: -10 });
	}).mouseup(function(){
		$('.works-map-wrapper').kinetic('stop');
	});
	$('.map-more-right').mousedown(function(){
		$('.works-map-wrapper').kinetic('start', {velocity: 10 });
	}).mouseup(function(){
		$('.works-map-wrapper').kinetic('stop');
	});
	$('.works-map').height(wHeight - outerBorder - innerBorder);
	$('.accordion-content a').each(function() {
		$(this).click(function(){
			var attrTag = $(this).attr("data-tag");
			$('.work-block').each(function(){
				var workTag = $(this).find('.work-tags .work-profile').attr("data-profile");
				if(attrTag != workTag) {
					$(this).fadeOut();
				} else {
					$(this).fadeIn();
				}
			});
		});
	});
	$('.category-all a').click(function(){
		$('.work-block').fadeIn();
	});
	$('.work-block').click(function(){
		$('.single-work-box').fadeIn();
		$('.single-work-box').promise().done(function(){
		    $('.single-work-loader').load('work1.html .single-work-content', function(){
		    	$('.single-work-loader').addClass('single-work-loader-up', {
		    		complete: function() {
		    			$('.single-work').removeClass('single-work-hide');
		    			setTimeout(function(){
		    				$('.single-work-card').removeClass('single-work-card-hide');
		    			}, 500);
		    		}
		    	});
		   //  	$('.related-works .work-block').click(function(){
		   //  		$('.single-work-loader').scrollTop(0).fadeOut();
		   //  		$('.single-work-loader').promise().done(function(){
					//     $('.single-work-loader').load('work2.html .single-work-content', function(){
					//     	$(this).fadeIn();
					//     });
					// });
		   //  	})
		   		$('.single-work-content').click(function(){
	   				$(this).parent().removeClass('single-work-loader-up', {
						complete: function() {
							$('.single-work-box').fadeOut();
						    $('.single-work-box').promise().done(function(){
							    $('.single-work-loader').html('');
							});
						}
					});	
				}).children().click(function(e){
					e.stopPropagation();
				});
		    });
		});
	});
	
	$('.single-work-close').click(function(){
		$('.single-work-loader').removeClass('single-work-loader-up', {
			complete: function() {
				$('.single-work-box').fadeOut();
			    $('.single-work-box').promise().done(function(){
				    $('.single-work-loader').html('');
				});
			}
		});	
	});
	

	$('.work-nav-arrow').click(function(){
		$(this).toggleClass('work-nav-arrow-open');
		$('.works-nav').toggleClass('works-nav-open');
	});
	
	// if(($('.preview-wrapper').offset().top - 100) < 0) {
	// 	$('.map-more-top').hide();
	// } else {
	// 	$('.map-more-top').show();
	// }
	
	// $('.preview-box').height((($('.preview-wrapper').outerHeight() - 96) / 8));
	// $('.preview-box').width(($('.preview-wrapper').outerWidth() / 8));
	// $('.inner-preview-box').css({height: (($('.works-map').innerHeight() / ($('.preview-wrapper').outerHeight())) * 100) + '%'});
	// $('.inner-preview-box').css({width: (($(window).innerWidth() - 260) / ($('.preview-wrapper').outerWidth()) * 100) + '%'});
	// window.setInterval(function(){
	// 	if($('.preview-wrapper').offset().top < 0) {
	// 		$('.inner-preview-box').css({'margin-top': (Math.abs($('.preview-wrapper').offset().top) / $('.preview-wrapper').innerHeight()) * 100 + '%'});
	// 	} else {
	// 		$('.inner-preview-box').css('margin-top', '0');
	// 	}
	// 	$('.inner-preview-box').css({'margin-left': (Math.abs($('.preview-wrapper').offset().left - 260) / $('.preview-wrapper').innerWidth()) * 100 + '%'});
	// 	console.log()
	// }, 100);	
}
function initMembers() {
	initGlobal();
	if($('.content').not('.content-loading')) {
		setTimeout(function(){
			$('.member-title').removeClass('member-title-hide');
		}, 1000);
		setTimeout(function(){
			$('.member-info').removeClass('member-info-hide');
		}, 1200);
		setTimeout(function(){
			$('.member-thumbnail-wrap').removeClass('member-thumbnail-hide')
		}, 1400);
	};
	
}
function initContact() {
	initGlobal();
	
}











