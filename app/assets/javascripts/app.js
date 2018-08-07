var Home = Barba.BaseView.extend({
    namespace: "home",
    onEnter: function () {},
    onEnterCompleted: function () {
    	preloaderTimeline();
        initHome();
        setTimeout(function(){
		    $.playSound("audios/backgroundAudio.wav");
		}, 3000);
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
    	preloaderTimeline();
        initWorks();
        loadSingleWork();
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
    	preloaderTimeline();
        initMembers();
    },
    onLeave: function () {},
    onLeaveCompleted: function () {
    	$('.menu-button').removeClass('close');
		$('.mobile-nav').removeClass('mobile-nav-open', 300);
    }
});
var Contact = Barba.BaseView.extend({
    namespace: "contact-us",
    onEnter: function () {},
    onEnterCompleted: function () {
    	preloaderTimeline();
    	initContact();
    },
    onLeave: function () {},
    onLeaveCompleted: function () {
    	$('.menu-button').removeClass('close');
		$('.mobile-nav').removeClass('mobile-nav-open', 300);
    }
});
var About = Barba.BaseView.extend({
    namespace: "about",
    onEnter: function () {},
    onEnterCompleted: function () {
    	preloaderTimeline();
        initAbout();
    },
    onLeave: function () {},
    onLeaveCompleted: function () {
    	$('.menu-button').removeClass('close');
		$('.mobile-nav').removeClass('mobile-nav-open', 300);
    }
});
var ErrorPage = Barba.BaseView.extend({
    namespace: "error",
    onEnter: function () {},
    onEnterCompleted: function () {
    	preloaderTimeline();
        initError();
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
		$('.loader-gif').fadeTo('500', 0, function() {
			$(this).hide();
		});
		setTimeout(function(){
		    $.playSound("audios/flip.wav");
		}, 500);
		var dUp = document.querySelector('.loader-bottom');
	    var dDown = document.querySelector('.loader-top');
	    var loadUp = anime({
		  targets: dUp,
		  height: '0%',
		  easing: 'easeInSine',
		  duration: 1500,
		});
		var loadDown = anime({
		  targets: dDown,
		  height: '0%',
		  easing: 'easeInSine',
		  duration: 1500,  
		});
	});
}
$(function () {
	initGlobal();
	Home.init();
	Works.init();
	Members.init();
	Contact.init();
	About.init();
	ErrorPage.init();
	Barba.Pjax.init();
    Barba.Prefetch.init();
    var FadeTransition = Barba.BaseTransition.extend({
	  start: function() {
	    Promise
	      .all([this.fadeOut(), this.newContainerLoading])
	      .then(this.fadeIn.bind(this));
	  },
	 
	  fadeOut: function() {
	    return new Promise(function(resolve){
	    	$('.loader-gif').fadeIn('1500', function(){
	    		$('.loader-gif').fadeTo('1500', 1);
	    	});
		    var dDown = document.querySelector('.loader-top');
		    anime({
			  targets: dDown,
			  height: '50%',
			  easing: 'easeInSine',
			  duration: 1000
			});
			var dUp = document.querySelector('.loader-bottom');
		    anime({
			  targets: dUp,
			  height: '50%',
			  easing: 'easeInSine',
			  duration: 1000,
			  complete: function(){
			  	resolve()
			  }
			});
	    })
	  },

	  fadeIn: function() {
	  	$('.loader-gif').fadeTo('500', 0, function() {
			$(this).hide();
		});
		setTimeout(function(){
		    $.playSound("audios/flip.wav");
		}, 1000);
		var _this = this;
		var dUp = document.querySelector('.loader-bottom');
	    var dDown = document.querySelector('.loader-top');
	    $(this.oldContainer).hide();
	    var loadUp = anime({
		  targets: dUp,
		  height: '0%',
		  easing: 'easeInSine',
		  duration: 1500,
		});
		var loadDown = anime({
		  targets: dDown,
		  height: '0%',
		  easing: 'easeInSine',
		  duration: 1500,
		});
		_this.done();
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
		if($('.mobile-nav').hasClass('mobile-nav-open')) {
			$(this).removeClass('close');
			$('.mobile-nav').removeClass('mobile-nav-open', 300);
		} else {
			$(this).addClass('close');
			$('.mobile-nav').addClass('mobile-nav-open', 300);
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
		if(contentAttr != 'home') {
			$(".nav-menu ul").addClass('works-nav');
		} else {
			$(".nav-menu ul").removeClass('works-nav');
		}
	});
	$('.lines-button').click(function(e) {
		if($('.social-menu').hasClass('social-menu-open')) {
			$('.lines-button').removeClass('close');
			$('.social-menu').removeClass('social-menu-open', 300);
		} else {
			$('.lines-button').addClass('close');
			$('.social-menu').addClass('social-menu-open', 300);
		}
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

    $.extend({
        playSound: function () {
            return $(
                   '<audio class="sound-player" autoplay="autoplay" style="display:none;">'
                     + '<source src="' + arguments[0] + '" />'
                     + '<embed src="' + arguments[0] + '" hidden="true" autostart="true" loop="false"/>'
                   + '</audio>'
                 ).appendTo('body');
        },
        stopSound: function () {
            $(".sound-player").remove();
        }
    });
	$('a, button, .keyreply-launcher').click(function(){
		$.playSound("audios/button.wav");
	});

}

function initHome() {
	initGlobal();
	$('.new-work-box').click(function(){
		$(".new-work-wrap").toggleClass('new-work-wrap-open');
		$(".new-work-button").toggleClass('new-work-button-open');
		$(this).toggleClass('new-work-box-open');
	});
	if ($(window).width() < 1800) {
	   $('.new-work').last().hide();
	}
	$(window).resize(function() {
		if ($(window).width() < 1800) {
		   $('.new-work').last().hide();
		} else {
			$('.new-work').last().show();
		}
	});
	setTimeout(function(){
	    var $age = $(".c-info-number[name='age'] span");
        var parts = $age.text().match(/^(\d+)(.*)/);
        if (parts.length < 2) return;
      
        var scale = 20;
        var delay = 50;
        var end = 0+parts[1];
        var next = 0;
        var suffix = parts[2];
        
        var runUp = function() {
          var show = Math.ceil(next);
          $age.text(''+show+suffix);
          if (show == end) return;
          next = next + (end - next) / scale;
          window.setTimeout(runUp, delay);
        }
        $age.css('opacity', '1');
        runUp();
	}, 3000);
	setTimeout(function(){
	    var $works = $(".c-info-number[name='works'] span");
        var parts = $works.text().match(/^(\d+)(.*)/);
        if (parts.length < 2) return;
      
        var scale = 20;
        var delay = 50;
        var end = 0+parts[1];
        var next = 0;
        var suffix = parts[2];
        
        var runUp = function() {
          var show = Math.ceil(next);
          $works.text(''+show+suffix);
          if (show == end) return;
          next = next + (end - next) / scale;
          window.setTimeout(runUp, delay);
        }
        $works.css('opacity', '1');
        runUp();
	}, 4000);
	setTimeout(function(){
	    var $coop = $(".c-info-number[name='coop'] span");
        var parts = $coop.text().match(/^(\d+)(.*)/);
        if (parts.length < 2) return;
      
        var scale = 20;
        var delay = 50;
        var end = 0+parts[1];
        var next = 0;
        var suffix = parts[2];
        
        var runUp = function() {
          var show = Math.ceil(next);
          $coop.text(''+show+suffix);
          if (show == end) return;
          next = next + (end - next) / scale;
          window.setTimeout(runUp, delay);
        }
        $coop.css('opacity', '1');
        runUp();
	}, 5000);
	$('.audio-wrap').click(function(){
		if($('.audio-wave span').hasClass('audio-pause')) {
			$('.audio-wave span').removeClass('audio-pause');
			$('audio').prop('muted', false);
		} else {
			$('.audio-wave span').addClass('audio-pause');
			$('audio').prop('muted', true);
		}
	});
}
function initWorks() {
	initGlobal();
	$(".sound-player").remove();
	var lisInRow = 0;
	function filterTop(top) {
		return function(i) {
			return $(this).offset().top == top;
		};
	}
	setTimeout(function(){
		$('.works-nav').removeClass('work-nav-hide');
	}, 2000);
	setTimeout(function(){
		$('.work-block').removeClass('work-block-hide');
	}, 2200);
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
	if($(window).width() > 1024) {
		$('.works-content').kinetic();
		$('.works-map').mouseout(function(){
			$('.works-map-wrapper').kinetic('detach');
		});
		$('.works-map').mouseover(function(){
			$('.works-map-wrapper').kinetic('attach');
		});
	} else {
		$('.works-content').kinetic('detach');
	}
	$(window).resize(function(){
		if($(window).width() > 1024) {
			$('.works-content').kinetic();
			$('.works-map').mouseout(function(){
				$('.works-map-wrapper').kinetic('detach');
			});
			$('.works-map').mouseover(function(){
				$('.works-map-wrapper').kinetic('attach');
			});
		}  
		if($(window).width() < 1023){
			$('.works-content').kinetic('detach');
			$('.works-map-wrapper').kinetic('detach');
		}
	});
	// $('.works-map').mouseout(function(){
	// 	$('.works-map-wrapper').kinetic('detach');
	// });
	// $('.works-map').mouseover(function(){
	// 	$('.works-map-wrapper').kinetic('attach');
	// });
	$('.works-map').mousemove(function(){
		if(($('.preview-wrapper').offset().top) < 0) {
			$('.map-more-top').fadeIn();
		} else {
			$('.map-more-top').fadeOut();
		}
		if(($('.preview-wrapper').offset().left) < 0) {
			$('.map-more-left').fadeIn();
		} else {
			$('.map-more-left').fadeOut();
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
	if($('.content').attr('date-namespace') == 'works') {
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
	}
	
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
					$(".works-category-filer span").html(attrTag);
				}
			});
		});
	});
	$('.category-all a').click(function(e){
		$('.work-block').fadeIn();
		$(".works-category-filer span").html("All");
	});
	$('.work-block').click(function(e){
		// e.stopPropagation();
		var $workBlock = $(this);
		$('.single-work-box').fadeIn();
		$('.single-work-box').promise().done(function(){
			$('.works-content').addClass('blur');
				$('.single-work-loader').load('/works/' + $workBlock.attr('data-work-id') + '?js=true .single-work-content', function(){
		    		history.pushState(null, '', '/works/' + $workBlock.attr('data-work-id'));
		    		var coverImage = $('.single-work-main-img img');
		    		var loadedImgNum = 0;
		    		coverImage.on('load', function(){
					  loadedImgNum += 1;
					  if (loadedImgNum == coverImage.length) {
					    $('.single-work-loader').addClass('single-work-loader-up', {
				    		complete: function() {
				    			$('.single-work').removeClass('single-work-hide');
				    			setTimeout(function(){
				    				$('.single-work-card').removeClass('single-work-card-hide');
				    				FB.XFBML.parse();
		    						instgrm.Embeds.process();
				    			}, 500);
				    		}
				    	});
					  }
					});
				   
				   // $('.single-work-loader').addClass('single-work-loader-up', {
			    // 		complete: function() {
			    // 			$('.single-work').removeClass('single-work-hide');
			    // 			setTimeout(function(){
			    // 				$('.single-work-card').removeClass('single-work-card-hide');
			    // 			}, 500);
			    // 		}
			    // 	});
				
		    	// $('.single-work-loader').addClass('single-work-loader-up', {
		    	// 	complete: function() {
		    	// 		$('.single-work').removeClass('single-work-hide');
		    	// 		setTimeout(function(){
		    	// 			$('.single-work-card').removeClass('single-work-card-hide');
		    	// 		}, 500);
		    	// 	}
		    	// });
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
							history.pushState(null, '', '/works');
							$('.works-content').removeClass('blur');
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
				history.pushState(null, '', '/works');
				$('.works-content').removeClass('blur');
				$('.single-work-box').fadeOut();
			    $('.single-work-box').promise().done(function(){
				    $('.single-work-loader').html('');
				});
			}
		});	
	});
	
	if($(window).width() < 600) {
		$('.works-nav').addClass('works-nav-open');
		setTimeout(function(){
			$('.work-nav-arrow').addClass('work-nav-arrow-open');
		}, 2000);		
	} else {
		$('.works-nav').removeClass('works-nav-open');
		$('.work-nav-arrow').removeClass('work-nav-arrow-open');
	}
	$('.work-nav-arrow').click(function(){
		$(this).toggleClass('work-nav-arrow-open');
		$('.works-nav').toggleClass('works-nav-open');
	});
	$('.works-tutorial-box button').click(function(){
		$('.works-tutorial-wrapper').addClass('works-tutorial-wrapper-hide').delay(1000).queue(function(){
			$(this).hide();
		});
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
function loadSingleWork() {
	var work_id_match = window.location.href.match(/works\/(\d+)/)
  if (work_id_match !== null && work_id_match[1] > 0) {
  	console.log("loading work" + work_id_match[1])
    $(".work-block[data-work-id='" + work_id_match[1] + "']").trigger("click")
  }	
}
function initMembers() {
	initGlobal();
	$(".sound-player").remove();
	
	$(window).load(function(){
		var config = {
			viewFactor: 0.15,
			duration: 800,
			distance: "0px",
			scale: 0.8,
			beforeReveal: function (domEl) { console.log(1) }, // 當啟動顯示前，則執行此函式
			beforeReset: function (domEl) { console.log(2) }, // 當重啟前，則執行此函式
			afterReveal: function (domEl) { console.log(3) }, // 當啟動後，則執行此函式
			afterReset: function (domEl) { console.log(4) } // 當重啟後，則執行此函式
		}

		window.sr = new ScrollReveal(config)
		var block = {
			reset: true,
		}
		sr.reveal(".member-thumbnail-block", block);
	})

	if($('.content').not('.content-loading')) {
		setTimeout(function(){
			$('.member-title').removeClass('member-title-hide');
		}, 2000);
		setTimeout(function(){
			$('.member-info').removeClass('member-info-hide');
		}, 2200);
		setTimeout(function(){
			$('.member-thumbnail-wrap').removeClass('member-thumbnail-hide')
		}, 2400);
	};
}
function initContact() {
	initGlobal();
	$('.service-process').each(function(){
		$(this).click(function(e){
			var serviceLink = $(this).attr("data-link");
			var serviceBigLink = $(this).attr("data-link-big");
			$(".contact-content").addClass('blur');
			if ($(window).width() < 600) {
				$(".contact-service-lightbox img").attr("src", serviceLink);
			} else {
				$(".contact-service-lightbox img").attr("src", serviceBigLink);
			}
			$(".contact-service-lightbox img").show();
			$(".contact-service-lightbox").show({
				done: function(){
					$(".contact-service-lightbox").animate({
						opacity: 1
					}, {
						duration: 500
					});
					$(".contact-service-lightbox").animate({
						top: 0
					}, {
						duration: 500
					});
				}
			});
		});
	});
	$('.lightbox-close, .lightbox-overlay').click(function(){
		$(".contact-content").removeClass('blur');
		$(".contact-service-lightbox").animate({
			top: "100%"
		}, {
			duration: 500
		});
		$(".contact-service-lightbox").animate({
			opacity: 0
		}, {
			duration: 500,
			complete: function(){
				$(".contact-service-lightbox").hide();
			}
		});

	});
}
function initAbout() {
	initGlobal();
	$(".sound-player").remove();
	setTimeout(function(){
		$('.creative-production-block img').removeClass('creative-img-hide');
		second();
	}, 2000);
	function second() {
		setTimeout(function(){
			$('.creative-production-info').removeClass('creative-production-info-hide');
		}, 500);
	}
	$(document).scroll(function(){
		var creativeTop = $(".creative-production-triangle").offset().top;
		var performanceTop = $(".performance-block img").offset().top;
		var teamTop = $(".team-block").offset().top;
		var teamImgTop = $(".team-img").offset().top;
		var winTop = $(window).scrollTop();
		var winHeight = $(window).height() / 2;
		// if(creativeTop - winTop < 200) {
		if(creativeTop - winTop < 200) {
			$(".strategy-block img").removeClass('strategy-img-hide');
			setTimeout(function(){
				$('.strategy-flake').removeClass('strategy-flake-hide');
				strategyFlake();
			}, 50);
			function strategyFlake() {
				setTimeout(function(){
					$('.strategy-info').removeClass('strategy-info-hide');
				}, 50);
			}
		}
		if(performanceTop - winTop < winHeight) {
			$(".performance-block img").removeClass('performance-img-hide');
			setTimeout(function(){
				$('.performance-info').removeClass('performance-info-hide');
			}, 500);
		}
		if(teamTop - winTop < winHeight) {
			$(".team-info").removeClass('team-info-hide');
		}
		if(teamImgTop - winTop < winHeight) {
			$('.team-img').removeClass('team-img-hide');
		}
	});		
}
function initError() {
	initGlobal();
	$(".sound-player").remove();
	setTimeout(function(){
		window.location.replace("/");
	}, 10000);
}
