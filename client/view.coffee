exponentiationBase = 3 # milliseconds
minute = 30*1000

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
		didIGuess(true)
		generateRandom()

	'click .i-didnt-know': (e) ->
		e.preventDefault()
		e.stopImmediatePropagation()
		didIGuess(false)
		generateRandom()

	'submit form': (e) ->
		console.log 'submit'
		e.preventDefault()
		if $('#word').val() is Session.get('word').word
			alert 'yessss'
			didIGuess(true)
		else
			alert 'NEIN!!!!:' + Session.get('word').word
			didIGuess(false)
		generateRandom()

	'loadedmetadata audio': (e) -> console.log 'emiliano'

Template.form.word = ->
	Session.get 'word'

Template.form.audio = ->
	w = Session.get 'word'
	return unless w
	encodeURI w.word + '... die ' + w.plural


didIGuess = (guess) ->
	w = Session.get('word')
	now = new Date().getTime()

	if guess
		w.interval *= exponentiationBase
	else
		w.interval /= exponentiationBase
	
	w.expirationDate = Math.round(now + minute + ((w.interval * 1000) * (Math.random() * 0.4 - 0.2)))

	console.log 'will show in the next X seconds', (w.expirationDate-now)/1000

	wrongOrRight = if (guess) then { correct: 1 } else { wrong: 1 }

	collection.update({ _id: w._id }, { 
		$inc: wrongOrRight
		$set: { 
			interval: w.interval
			expirationDate: w.expirationDate
		}
	})