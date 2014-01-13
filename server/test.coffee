program = require 'commander'
request = require 'request'


states = ['st0-active', 'st1-welcome', 'st2-discarded', 'st3-old']
names = ['Andres', 'Jose', 'Maria', 'Concha', 'Nacho', 'Patri', 'Sergio', 'Pepe', 'Jorge', 'Asunción','Andrea','Camila','Cristina']
surnames = ['Portabales', 'Pérez', 'Domínguez', 'Fernández', 'Costas', 'Revilla', 'Zolle', 'Vara']

sedes = ['Vigo','Coruña','Santiago','Lugo']

days = [1..30]
months = [1..12]
years = [2000..2013]


# http = require 'http'
# querystring = require 'querystring'

#post_data_formacion = querystring.stringify
#
#
#

#
# TRAININGS
# 
post_data_formacion = 
	'name' : 'Soberania alimentaria66',
	'date': '2014-09-06',
	'place': 'Santiago de Compostela',
	'lecturer' : 32

post_data_formacion_members =
	'members' : ['45','46','98','200','345','1']

post_data_formacion_members2 =
	'members' : ['999','888', "777"]

post_data_formacion_delete_members =
	'members' : ['999','888', "777"]


			
# request.post 'http://localhost:7777/formacion',
# 	{ form: post_data_formacion },
# 	(error, response, body) =>
# 		if (!error && response.statusCode == 200)
# 			console.log(body)


# request.put 'http://localhost:7777/formacion/52c5ea79d38d641b256685fb',
# 	{ form: post_data_formacion },
# 	(error, response, body) =>
# 		if (!error && response.statusCode == 200)
# 			console.log(body)

# request.post 'http://localhost:7777/formacion/52c5ea79d38d641b256685fb/members',
# 	{ form: post_data_formacion_members2 },
# 	(error, response, body) =>
# 		if (!error && response.statusCode == 200)
# 			console.log(body)

# request.del 'http://localhost:7777/formacion/52c5ea79d38d641b256685fb/members',
# 	{ form: post_data_formacion_delete_members },
# 	(error, response, body) =>
# 		if (!error && response.statusCode == 200)
# 			console.log(body)

# request.get 'http://localhost:7777/formacion/',
# 	{ form: post_data_formacion_delete_members },
# 	(error, response, body) =>
# 		if (!error && response.statusCode == 200)
# 			for formacion in JSON.parse( body)
# 				console.warn "---------------------------"
# 				console.warn formacion

# request.get 'http://localhost:7777/formacion/52c5ea79d38d641b256685fb',
# 	{ form: post_data_formacion_delete_members },
# 	(error, response, body) =>
# 		if (!error && response.statusCode == 200)
# 			console.warn body


#
# VOLUNTEERS
#

put_data_volunteer_update = 
	'name' : 'Andrés Estévez Costas',
	'venue': 'Nigrán',
	'date': '2007/10/23'

delete_data_volunteer =
	'ids':['52cad27e91cfac0975dfc3b2']

# request.post 'http://localhost:7777/volunteer',
# 	{ form: post_data_volunteer },
# 	(error, response, body) =>
# 		if (!error && response.statusCode == 200)
# 			console.log(body)

# request.put 'http://localhost:7777/volunteer/52cad27e91cfac0975dfc3b2',
# 	{ form: put_data_volunteer_update },
# 	(error, response, body) =>
# 		if (!error && response.statusCode == 200)
# 			console.log(body)

# request.del 'http://localhost:7777/volunteer',
#  	{ form: delete_data_volunteer },
# 	(error, response, body) =>
# 		if (!error && response.statusCode == 200)
# 			console.log(body)


program
	.version('0.0.1')
	.option('-L, --listvolunteers', 'Retrieve list of volunteers')
	.option('-A, --addvolunteers <counter>', 'Add random volunteers', parseInt)
	.option('-G, --getvolunteer <id>', 'Get volunteer')
	.parse(process.argv);


if program.getvolunteer
	request.get "http://localhost:7777/volunteer/#{program.getvolunteer}",
		(error, response, body) =>
			if (!error && response.statusCode == 200)
				console.warn body
	

if program.listvolunteers
	request.get 'http://localhost:7777/volunteer/',
		(error, response, body) =>
			if (!error && response.statusCode == 200)
				for volunteer in JSON.parse( body)
					console.warn volunteer

if program.addvolunteers
	console.warn "adding volunteers"
	for count in [1..program.addvolunteers]
		post_data_volunteer = {} 
		post_data_volunteer.name = "#{names[Math.floor(Math.random() * names.length)]}  #{surnames[Math.floor(Math.random() * surnames.length)]} #{surnames[Math.floor(Math.random() * surnames.length)]}" 
		post_data_volunteer.venue = sedes[Math.floor(Math.random() * sedes.length)]
		post_data_volunteer.state = states[Math.floor(Math.random() * states.length)]
		month = Math.floor(Math.random() * 12) + 1
		day =  Math.floor(Math.random() * 30) + 1
		year = Math.floor(Math.random() * 12) + 2000
		post_data_volunteer.date = "#{year}/#{month}/#{day}"
		console.warn post_data_volunteer
		request.post 'http://localhost:7777/volunteer',
			{ form: post_data_volunteer },
			(error, response, body) =>
				if (!error && response.statusCode == 200)
					console.log(body)
