controllers = {}
controllers.VolunteersList = require "controllers/VolunteersList"
controllers.Communication = require "controllers/Communication"
controllers.VolunteerDetailed = require "controllers/VolunteerDetailed"
controllers.SideMenu = require "controllers/SideMenu"

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
			items: @items

		items = {}
		items["nivel1"] = ["1.1", "1.2"]
		items["nivel2"] = ["2.1", "2.2", "2.3", "2.4"]

		sidemenu = new controllers.SideMenu
			el: "#esf-menu"
			items: items


		communication = new controllers.Communication
		communication.getVolunteers()
	
module.exports = App
