class Communication extends Spine.Controller

	constructor: ->
		super
		Spine.bind "selected-volunteer", (e) =>			
			console.warn "[COMMUNICATION] Selected volunteer"
			volunteerDetailed = {}
			volunteerDetailed.photo = 'http://m.c.lnkd.licdn.com/media/p/5/005/02f/269/07af33c.jpg'
			volunteerDetailed.name = "Tomás Bande Sánchez"
			volunteerDetailed.venue = "Lugo"
			volunteerDetailed.membership = "2008-05-05"
			volunteerDetailed.leave = null
			volunteerDetailed.state = 'st0-active'
			volunteerDetailed.activities = [{type:'training', name:'Formación en Xenero', date:'2008/10/10'}, {type:'xuntanza', name:'Xuntanza Novembro', date:'2008/10/10'}, {type:'xuntanza', name:'Xuntanza Marzo', date:'2008/10/10'},]
			volunteerDetailed.welcome = [{date:'2009/05/05', comment: "contacta via correo electronico"}, {date:'2009/05/06', comment: "Se reune con XXXX"}]
			Spine.trigger 'volunteer-detailed', volunteerDetailed
		
		Spine.bind "edit", (field, value) =>
			console.warn "[COMMUNICATION] Edit #{field}   #{value}"


	# getVolunteers: () =>
		
		
module.exports = Communication