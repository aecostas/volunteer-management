controllers = {}
controllers.VolunteersList = require "controllers/VolunteersList"

class App extends Spine.Controller
	elements:
		"#uri": "$uri"
		"#password": "$password"
		"#server": "$server"
		
	constructor: ->
		super
		states = ['st0-active', 'st1-welcome', 'st2-discarded', 'st3-old']
		sedes = ['Vigo','Coruña','Santiago','Lugo']
		volunteers = []

		for i in [0..20]
			volunteers[i] = {}
			volunteers[i].sede = sedes[Math.floor(Math.random() * sedes.length)]
			volunteers[i].name = "[volunteer]"
			volunteers[i].state = states[Math.floor(Math.random() * states.length)]

		sortedVolunteers = _.groupBy volunteers, (volunteer) =>
			return volunteer.sede
			
		volunteersList = new controllers.VolunteersList
			volunteers: sortedVolunteers
			el: "#esf-listview"
		
module.exports = App
