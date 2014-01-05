# esf-server
# (c) 2013 - Enxeñería Sen Fronteiras - Galicia
#
# This module exports the Express.js app that runs the server
#
# Dependencies
require('coffee-script')

#D               = require("promise.coffee").Deferred
express         = require "express"
util            = require "util"
# path            = require "path"
# fs              = require 'fs'
# program         = require "commander"
# u               = require 'underscore'
# crypto          = require "crypto"
# WebSocketServer = require("ws").Server

# LDAP            = require "./ldap"
# DB              = require "./db"

# https           = require 'https'
http            = require 'http'


Db = require('mongodb').Db;
Connection = require('mongodb').Connection;
Server = require('mongodb').Server;
BSON = require('mongodb').BSON;
ObjectID = require('mongodb').ObjectID;


# mongo = require('mongodb').MongoClient
# monk = require 'monk'
# db = monk 'localhost:27017/event'


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
	# @option options   data        [String]  The path to the folder with .nosql files
	# @option options   files       [String]  The path to the folder with shared files
	# @option options   static      [String]  The path to the static content (the webphone)
	# @option options   ldap        [String]  The path to the LDAP configuration file
	# @option options   cert        [String]  The path to the SSL certificate
	# @option options   port        [Number]  The HTTP port to listen on
	# @option options   ports       [Number]  The HTTPS port to listen on
	# @option options   wsport      [Number]  The WebSocketServer port to listen on
	# @option options   authBackend [String]  The name of Auth backend to use
	# @option optHns    authHooks   [Array]   The Auth Hooks for the auth process
	# @option options   authEnabled [Boolean] True for enabling the authentication process
	#
	constructor: (options) ->
		@options     = options
		@filesStatus = []


	getCollection: (name, callback) =>
		@db.collection name, (error, collection) =>
			if error
				callback error
			else
				callback null, collection
			

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

		http.createServer(app).listen @options.port

		if @options.ports > 0
			httpsOptions      = { }
			httpsOptions.key  = fs.readFileSync @options.cert + '/server.key'
			httpsOptions.cert = fs.readFileSync @options.cert + '/server.crt'
			https.createServer(httpsOptions, app).listen @options.ports

module.exports = ESFServer