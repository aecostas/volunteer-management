views = {}
views.volunteersList "views/volunteerslist"

class VolunteersList extends Spine.Controller

	events:
		"click .stage":"selectStage"

	constructor: ->
		super

#	render: =>
#		@append views.volunteersList 

						
module.exports = VolunteersList