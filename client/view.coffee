Template.form.events
	'click .pass': (e) ->
		e.preventDefault()
		e.stopImmediatePropagation()
		generateRandom()

	'click .i-know-it': (e) ->
		e.preventDefault()
		e.stopImmediatePropagation()
		$('.form-signin').toggleClass('flipped')
		$('audio')[0].play()

	'click .i-did-know': (e) ->
		e.preventDefault()
		e.stopImmediatePropagation()
		collection.update { _id: Session.get('word')._id }, $inc: { correct: 1 }
		generateRandom()

	'click .i-didnt-know': (e) ->
		e.preventDefault()
		e.stopImmediatePropagation()
		collection.update { _id: Session.get('word')._id }, $inc: { wrong: 1 }
		generateRandom()

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

	'loadedmetadata audio': (e) -> console.log 'emiliano'

Template.form.word = ->
	Session.get 'word'

Template.form.audio = ->
	w = Session.get 'word'
	encodeURI w.word + '... die ' + w.plural