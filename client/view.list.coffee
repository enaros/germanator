# ----------------------------------------------------------------------
# Template Helpers
# ----------------------------------------------------------------------
Template.list.list = ->
	if Session.get('search')? is ''
		collection.find()
	else
		s = new RegExp(Session.get('search'), 'ig')
		collection.find(word: s)

Template.list.disabled = (item) ->
	if item.disabled then 'disabled' else ''

# ----------------------------------------------------------------------
# Template Events
# ----------------------------------------------------------------------
Template.list.events
	'submit .form-search': (e) ->
		e.preventDefault()
		$('#word').focus().val $('.search-query').val()
		openNewEditWord()

	'keyup .search-query': (e) ->
		Session.set 'search', $(e.currentTarget).val()

	'click .list-item.disabled': (e) ->
		collection.update {_id: @_id }, $set: { disabled: false }

	'click .list-item:not(.disabled)': (e) ->
		return if window.animation # prevent click when Snap is animating
		console.log e, this
		openNewEditWord(true)
		$('#word').focus().val @word
		$('#plural').val @plural
		$('#translation').val @english
		$('#search').val @search
		$('#new-edit-word form').find('[type=hidden]').val @_id

# ----------------------------------------------------------------------
# Template 'new' Helpers
# ----------------------------------------------------------------------
Template.new.events
	'click .cancel-button': (e) ->
		e.preventDefault()
		closeNewEditWord()

	'click .delete-button': (e) ->
		e.preventDefault()
		id = $('#new-edit-word form').find('[type=hidden]').val()
		collection.update {_id: id }, $set: { disabled: true }
		closeNewEditWord()

	'submit form': (e) ->
		e.preventDefault()
		formData = deParam $('#new-edit-word form').serialize()
		id = formData._id
		delete formData._id
		
		if id
			collection.update {_id: id }, $set: formData
		else
			collection.insert formData

		closeNewEditWord()

# ----------------------------------------------------------------------
# Auxiliar functions
# ----------------------------------------------------------------------
closeNewEditWord = ->
	$('#new-edit-word').removeClass('show').removeClass 'edit'
	$('#list').css 'overflow', 'auto'
	$('#new-edit-word form')[0].reset()
	$('#new-edit-word form').find('[type=hidden]').val ''
	Session.set 'search', ''

openNewEditWord = (edit) ->
	$('#list').scrollTop(0).css 'overflow', 'hidden'
	$('#new-edit-word').addClass 'show'
	$('#new-edit-word').addClass 'edit' if edit
