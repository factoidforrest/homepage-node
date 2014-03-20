define 'jquery', () ->
	nav = $('.nav')
	nav.find().click (e) ->
		e.preventDefault()
		console.log('click event is', e)