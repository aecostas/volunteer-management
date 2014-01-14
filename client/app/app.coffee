controllers = {}
controllers.VolunteersList = require "controllers/VolunteersList"
controllers.Communication = require "controllers/Communication"
controllers.VolunteerDetailed = require "controllers/VolunteerDetailed"

class App extends Spine.Controller
	elements:
		"#uri": "$uri"
		"#password": "$password"
		"#server": "$server"

	constructor: ->
		super
		states = ['st0-active', 'st1-welcome', 'st2-discarded', 'st3-old']
		sedes = ['Vigo','Coruña','Santiago','Lugo']
		Spine.bind 'volunteers', (volunteers) =>
			sortedVolunteers = _.groupBy volunteers, (volunteer) =>
				return volunteer.venue

			@volunteersList = new controllers.VolunteersList
				volunteers: sortedVolunteers
				el: "#esf-listview"



		volunteerDetailedCtrl = new controllers.VolunteerDetailed
			el: "#volunteer-detailed"
#		volunteerDetailedCtrl.setVolunteer (volunteerDetailed)

		communication = new controllers.Communication
		communication.getVolunteers()
			
		@volunteersList.bind "selected-volunteer", (e) =>
			console.warn "[app.coffee] Selected volunteer"
		
module.exports = App
