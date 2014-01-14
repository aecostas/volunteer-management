views = {}
views.volunteerDetailed = require "views/volunteerDetailed"

class VolunteerDetailed extends Spine.Controller
	events:
		"click":"prueba"
		"click #editdetailedname":"editName"
		"keydown #editdetailedname":"doneEditNameHandler"
		"click #detailedvenue": "editVenue"
		"change #selectvenue": "doneEditVenue"
		
	constructor: ->
		super
		Spine.bind "volunteer-detailed", (@volunteer) =>
			@render()

	prueba:() =>
		if @$('#editdetailedname').hasClass 'editting'
			@doneEditName()

	setVolunteer: (@volunteer) =>
		@render()

	render: =>
		@html views.volunteerDetailed @volunteer

	editName: (e) =>
		console.warn "editName"
		@$('#editdetailedname').addClass('editting')
		@$('#editdetailedname').attr('readonly', false)
		e.stopPropagation()
		
	doneEditName:() =>
		@$('#editdetailedname').removeClass('editting')
		@$('#editdetailedname').attr('readonly', true)
		Spine.trigger 'edit',  @volunteer._id,'name', $('#editdetailedname').val()
		

	doneEditNameHandler: (e) =>
		if e.keyCode == 13
			e.preventDefault()
			@doneEditName()

	editVenue: (e) =>
		@$('#formvenue').show()
		@$('#detailedvenue').hide()

	doneEditVenue: (e) =>
		console.warn "done edit venue"
		@$('#detailedvenue').text @$('#selectvenue').val()
		@$('#formvenue').hide()
		@$('#detailedvenue').show()
		Spine.trigger 'edit',  @volunteer._id, 'venue', @$('#selectvenue').val()
		
module.exports = VolunteerDetailed

