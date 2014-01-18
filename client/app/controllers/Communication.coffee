class Communication extends Spine.Controller

	constructor: ->
		super
		Spine.bind "selected-volunteer", (id) =>
			success = (data, textStatus, jqXHR) =>
				console.warn data[0]
				data[0].photo="http://m.c.lnkd.licdn.com/media/p/5/005/02f/269/07af33c.jpg" if not data[0].photo?  #fixme
				Spine.trigger 'volunteer-detailed', data[0]

			error = (data) =>
				console.warn data

			$.ajax
				type: 'GET'
				contentType: 'application/json'
				url: "http://localhost:7777/volunteer/#{id}"
				success: success
				error: error

		Spine.bind "edit", (id, field, value, subfield) =>
			console.warn "Editing user  #{id} #{field}:#{value}"
			success = (data, textStatus, jqXHR) =>
				console.warn data

			error = (data) =>
				console.warn data
		
			$.ajax
				type: 'PUT'
				contentType: 'application/json'
				url: "http://localhost:7777/volunteer/#{id}/#{field}/#{value}/#{subfield}"
				success: success
				error: error



	getVolunteers: () =>
		success = (data, textStatus, jqXHR) =>
			console.warn data
			Spine.trigger 'volunteers', data

		error = (data) =>
			console.warn data
		
		$.ajax
			type: 'GET'
			contentType: 'application/json'
			url: "http://localhost:7777/volunteer/"
			success: success
			error: error

module.exports = Communication