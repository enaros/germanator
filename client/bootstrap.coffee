Meteor.startup -> 
	# $('input').select()
	Session.set 'search', ''
	window.snapper = new Snap
		element: document.getElementById('content')
		disable: 'right'
		maxPosition: 201

	window.snapper.on 'animated', -> window.animation = false
	window.snapper.on 'drag', -> window.animation = true