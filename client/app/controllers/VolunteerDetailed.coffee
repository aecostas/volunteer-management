views = {}
views.volunteerDetailed = require "views/volunteerDetailed"

class VolunteerDetailed extends Spine.Controller
	events:
		"click":"prueba"
		"click #editdetailedname":"editName"
		"keydown #editdetailedname":"doneEditNameHandler"
		"click #detailedvenue": "editVenue"
		"change #selectvenue": "doneEditVenue"
		"click .signagreed": "signAgreement"
		
	constructor: ->
		super
		Spine.bind "volunteer-detailed", (@volunteer) =>
			for year in _.keys @volunteer.agreement
				console.warn year
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


	signAgreement: (e) =>
		value=null
		year= e.target.id[e.target.id.length-4..e.target.id.length]
		if $("#agreedIndicator#{year}").hasClass "agreedfalse"
			$("#agreedIndicator#{year}").removeClass "agreedfalse"
			$("#agreedIndicator#{year}").addClass "agreedtrue"
			$("#signagreed#{year}").text "(deshacer)"
			value=true
		else
			$("#agreedIndicator#{year}").removeClass "agreedtrue"
			$("#agreedIndicator#{year}").addClass "agreedfalse"
			$("#signagreed#{year}").text "(firmar)"
			value=false

		Spine.trigger 'edit',  @volunteer._id, 'agreement', value, year
		
module.exports = VolunteerDetailed

