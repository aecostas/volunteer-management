request = require 'request'

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
post_data_volunteer = 
	'name' : 'Andrés Estévez Costas',
	'venue': 'Vigo',
	'date': '2007/10/23'

put_data_volunteer_update = 
	'name' : 'Andrés Estévez Costas',
	'venue': 'Nigrán',
	'date': '2007/10/23'

delete_data_volunteer =
	'ids':['52cad27e91cfac0975dfc3b2']

request.post 'http://localhost:7777/volunteer',
	{ form: post_data_volunteer },
	(error, response, body) =>
		if (!error && response.statusCode == 200)
			console.log(body)

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