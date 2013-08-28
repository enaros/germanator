Template.bg.events
	'click .img' : (e) ->
		return if window.animation
		
		el = $(e.currentTarget)
		if el.hasClass 'on'
			$('.img').removeClass('off').removeClass('on')
		else
			$('.img').addClass('off').removeClass('on')
			el.removeClass('off').addClass('on')
			collection.update { _id: Session.get('word')._id }, $set: { image: el.css('background-image') }