Meteor.startup -> 
	# $('input').select()
	window.snapper = new Snap
		element: document.getElementById('content')
		disable: 'right'
		maxPosition: 201

	window.snapper.on 'animated', -> console.log 'dragend'; window.animation = false
	window.snapper.on 'drag', -> console.log 'dragstart'; window.animation = true