views = {}
views.volunteersList = require "views/volunteersList"

class VolunteersList extends Spine.Controller

	events:
		"click .row-volunteer" : "selectVolunteer"

	constructor: ->
		super
		@render()
		
	render: =>
		_.each @volunteers, (value, key) =>
			item = {}
			item.venue = key
			item.volunteers = _.sortBy value, (volunteer) =>
				return volunteer.state
			console.warn value
			@append views.volunteersList item


	selectVolunteer: (e) =>
		return if @$('#'+e.currentTarget.id).hasClass 'selected'
#		@trigger 'selected-volunteer', e.currentTarget.id
		Spine.trigger 'selected-volunteer', e.currentTarget.id
		# FIXME: global access!
		$('.row-volunteer').removeClass('selected')	
		@$('#'+e.currentTarget.id).addClass('selected')
		@selected = true


module.exports = VolunteersList