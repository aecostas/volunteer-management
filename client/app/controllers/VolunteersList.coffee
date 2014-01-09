views = {}
views.volunteersList = require "views/volunteersList"

class VolunteersList extends Spine.Controller

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

						
module.exports = VolunteersList