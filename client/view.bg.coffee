Template.bg.events
	'click .img' : (e) ->
		el = $(e.currentTarget)
		if el.hasClass 'on'
			$('.img').removeClass('off').removeClass('on')
		else
			$('.img').addClass('off').removeClass('on')
			el.removeClass('off').addClass('on')