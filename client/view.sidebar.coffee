Template.sidebar.events
	'click #show-list': ->
		$('#list').toggleClass 'show'
		window.snapper.close()