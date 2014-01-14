# esf-server
# (c) 2013 - Enxeñería Sen Fronteiras - Galicia
#
# This module exports the Express.js app that runs the server
#
# Dependencies
require('coffee-script')

express         = require "express"
util            = require "util"
http            = require 'http'


Db = require('mongodb').Db;
Connection = require('mongodb').Connection;
Server = require('mongodb').Server;
BSON = require('mongodb').BSON;
ObjectID = require('mongodb').ObjectID;

# ESFServer class
#
# This class encapsulates the methods exposed by the Express.js app
#
# The server exposes a REST interface for managing contacts, calls and
# users.
#
# If LDAP is enabled, a /search endpoint provides contact search against
# the desired LDAP server.
#
# The /login resource checks user credentials and returns configuration
# information to the client (IMS credentials and supported capabilities)
class ESFServer

	# The constructor
	#
	# @param  options   [Object] The command line options
	# @option options   port        [Number]  The HTTP port to listen on
	# @option options   ports       [Number]  The HTTPS port to listen on
	# @option options   wsport      [Number]  The WebSocketServer port to listen on
	#
	constructor: (options) ->
		@options     = options
		@filesStatus = []


	run: () =>
		@db = new Db('event', new Server('localhost', 27017, {auto_reconnect: true}, {}));
		@db.open(()=>)

		app = express()
		app.use express.compress()
		app.use express.bodyParser()
		app.use express.static @options.static
		app.use (req, res, next) ->
			util.inspect req
			do next


		########################################################
		# TRAINING FUNCTIONS                                   #
		########################################################

		# GET /formacion
		#
		# Retrieves the list of all events (only name, date and place)
		#
		# @return 200 OK
		#
		app.get "/formacion", (req, res) =>
			console.warn "GET /formacion"
			collection = @db.collection('prueba5')
			data = ""
			collection.find({},{ name:true, date:true, place:true }).toArray (err, docs) =>
				res.status(200).send docs


			

		# GET /formacion/:id
		#
		# Retrieves all the information about the event :id
		#
		# @param id [String] Event identifier
		#
		# @return 200 OK
		#
		app.get "/formacion/:id", (req, res) =>
			console.warn "GET /formacion/:id"
			id  = req.params.id
			collection = @db.collection('prueba5')
			collection.find({_id:id}).toArray (err, docs) =>
				console.warn docs
				res.status(200).send docs



		# POST /formacion
		#
		# Saves a new event
		#
		# @param name [String]
 		# @param date [String]
		# @param place [String]
		# @param lecturer [String]
		# 
		# @return 200 OK
		#
		app.post "/formacion", (req, res) =>
			console.warn "POST /formacion"
			collection = @db.collection('prueba5')

			data = {}
			data.name = req.body.name
			data.date = req.body.date
			data.place = req.body.place
			data.lecturer = req.body.lecturer
			data.members = []

			# does it make sense to distinguish between assistants and "wishes"
			# assistant -> name ans surname
			# "wish to go" -> counter?

			collection.insert data, (err, docs) =>
				if err
					console.warn "Error inserting document"
				else
					console.warn "Inserted document #{docs[0]._id}"

			res.status(200).send "adios!"


		# PUT /formacion/:id
		#
		# Updates the event identified by <id>
		#
		# @param name [String]
 		# @param date [String]
		# @param place [String]
		# @param lecturer [String] 
		# 
		# @return 200 OK
		#
		app.put "/formacion/:id", (req, res) =>
			console.warn "PUT /formacion/:id"
			id  = req.params.id
			data = {}
			data.name = req.body.name
			collection = @db.collection('prueba5')
			collection.update {_id: ObjectID id},  {"$set": data}, true, false
			res.status(200).send "adios!"


		app.delete "/formacion", (req, res) =>
			console.warn "DELETE /volunteer"
			collection = @db.collection('prueba5')
			ids  = req.body.ids
			for id in ids
				collection.remove { _id: ObjectID id }
			res.status(200).send ""


		app.post "/formacion/:id/members", (req, res) =>
			console.warn "POST /formacion/:id/members"
			id  = req.params.id
			collection = @db.collection('prueba5')
			collection.update { _id: ObjectID id},  {"$addToSet": {members: {$each: req.body.members } } }, true, false
			console.warn req.body.members
			res.status(200).send "Ready!"


		app.delete "/formacion/:id/members", (req, res) =>
			console.warn "DELETE /formacion/:id/members"
			id  = req.params.id
			collection = @db.collection('prueba5')
			for contactid in req.body.members
				collection.update { _id: ObjectID id},  {"$pull": {members:  contactid } }, true, false
			res.status(200).send "Ready!"

		# TODO: formaciones hechas por un voluntario

		########################################################
		# VOLUNTEERS FUNCTIONS                                 #
		########################################################
		# list -> criteria
		# update

		app.get "/volunteer", (req, res) =>
			console.warn "GET /volunteer"
			collection = @db.collection 'volunteer'
			collection.find({},{name:true, state:true, venue:true}).toArray (err, docs) =>
				res.status(200).send docs


		app.get "/volunteer/:id", (req, res) =>
			console.warn "GET /volunteer/:id"
			console.warn req.params.id
			id=req.params.id
			
			collection = @db.collection 'volunteer'
			collection.find({_id:ObjectID id}).toArray (err, docs) =>
				console.warn docs
				res.status(200).send docs

		
		# POST /volunteer/:id
		#
		# Saves a new volunteer
		#
		# @param name [String]
 		# @param date [String]
		# @param venue [String]
		# 
		# @return 200 OK
		app.post "/volunteer", (req, res) =>
			console.warn "POST /volunteer"
			collection = @db.collection('volunteer')
			currentyear = new Date().getFullYear()
			data = {}
			data.name = req.body.name
			data.date = req.body.date
			data.venue = req.body.venue
			data.state = req.body.state
			data.agreement = {}
			data.agreement[currentyear] = false

			collection.insert data, (err, docs) =>
				if err
					console.warn "Error inserting document"
				else
					console.warn "Inserted document #{docs[0]._id}"

			res.status(200).send "OK!"


		# PUT /volunteer/:id
		#
		# Updates a new volunteer
		#
		# @param name [String]
 		# @param date [String]
		# @param venue [String]
		# 
		# @return 200 OK
		app.put "/volunteer/:id", (req, res) =>
			id  = req.params.id
			console.warn "PUT /volunteer/#{id}"
			data = {}
			data.name = req.body.name
			data.date = req.body.date
			data.venue = req.body.venue
			data.state = req.body.state
			console.warn data
			collection = @db.collection('volunteer')
			collection.update {_id: ObjectID id},  {"$set": data}, true, false

			res.status(200).send "adios!"


		# PUT /volunteer/:id/:field/:value
		#
		# Updates a new volunteer
		# 
		# @return 200 OK
		app.put "/volunteer/:id/:field/:value", (req, res) =>
			console.warn "PUT /volunteer/#{id}/#{req.params.field}/#{req.params.value}"
			id  = req.params.id
			data = {}
			data[req.params.field] = req.params.value
			collection = @db.collection('volunteer')
			collection.update {_id: ObjectID id}, {"$set": data}
			res.status(200).send "adios!"


		# DELETE /volunteer/:id
		#
		# Remove the given volunteers in the param 'ids'
		#
		# @params ids [Array] Volunters to remove
		# 
		# @return 200 OK
		#
		app.delete "/volunteer", (req, res) =>
			# o simplemente marcarlo como dado de baja
			console.warn "DELETE /volunteer"
			collection = @db.collection('volunteer')
			ids  = req.body.ids
			for id in ids
				collection.remove { _id: ObjectID id }
			res.status(200).send ""

		http.createServer(app).listen @options.port

		if @options.ports > 0
			httpsOptions      = { }
			httpsOptions.key  = fs.readFileSync @options.cert + '/server.key'
			httpsOptions.cert = fs.readFileSync @options.cert + '/server.crt'
			https.createServer(httpsOptions, app).listen @options.ports

module.exports = ESFServer

# TODO: almacenar cambios: cambios de sede,
# gestión de compromisos -> como añadir un nuevo año?
# listas de correo en las que está la persona voluntaria
# añadir etiquetas a las formaciones
# añadir cargos a los voluntarios