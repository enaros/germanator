Template.form.events
	'click .pass': (e) ->
		e.preventDefault()
		e.stopImmediatePropagation()
		console.log 'pass'
		generateRandom()

	'click .i-know-it': (e) ->
		e.preventDefault()
		e.stopImmediatePropagation()
		console.log 'i-know-it'
		$('.form-signin').toggleClass('flipped')

	'submit form': (e) ->
		console.log 'submit'
		e.preventDefault()
		if $('#word').val() is Session.get('word').word
			alert 'yessss'
			collection.update { _id: Session.get('word')._id }, $inc: { correct: 1 }
		else
			alert 'NEIN!!!!:' + Session.get('word').word
			collection.update { _id: Session.get('word')._id }, $inc: { wrong: 1 }
		generateRandom()

Template.form.word = ->
	Session.get 'word'