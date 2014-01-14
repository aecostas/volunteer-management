#
# esf-server launcher
# (c) 2013 - Enxeñería Sen Fronteiras - Galicia
#
# This program launches the esf-server Express.js app
#
# ## Dependencies
#
# # Allow `.coffee` *requires*.

####!/usr/bin/env node
#
require('coffee-script')

util    = require "util"
path    = require "path"
fs      = require "fs"
program = require "commander"
u       = require 'underscore'

# ## Program options
program
	.version("1.1.4")
	.option("-p, --port <port>", "HTTP server port", parseInt, 7777)
	.option("-P, --ports <port>", "HTTPS server port", parseInt, -1)
	.option("-w, --websocket <port>", "Fileserver websocket port", parseInt, 8888)
	.option("-s, --static <path>", "Static path to serve")
	.option("-d, --datapath <path>", "Database files path")
	.option("-f, --filespath <path>", "Shared files path")
	.option("-l, --ldap <path>", "LDAP configuration JSON")
	.option("-R, --cert <path>", "HTTPS cert path")
	.option("-a, --auth <name>", "Authentication backend to use")
	.option("-A, --authOptions <JSON options>", "Authentication backend options")
	.option("-c, --credentials <name>", "Credentials backend to use")
	.option("-C, --credentialsOptions <JSON options>", "Credentials backend options")

program.parse process.argv


# Default options.

ports        = {}
ports.http   = program.port
ports.https  = program.ports
ports.wsport = program.websocket

paths        = {}
paths.files  = path.resolve program.filespath or "./files/"
paths.data   = path.resolve program.datapath  or "./data/"
paths.static = path.resolve program.static    or "../client/public/"
paths.cert   = path.resolve program.cert      or "./cert/"
for k, v of paths
	paths[k] = path.join v, "/"


# Show used options.
u.map ["HTTP server open -> Port #{ports.http}",
	"HTTPS server open -> Port #{ports.https}",
	"WS server open   -> Port #{ports.wsport}",
	"Static folder    -> #{paths.static}",
	"Databases folder -> #{paths.data}"],
	util.log


# Start sippo-server
ESFServer = require('./esf-server')
esfServer = new ESFServer
	data        : paths.data
	files       : paths.files
	static      : paths.static
	cert        : paths.cert
	port        : ports.http
	ports       : ports.https
	wsport      : ports.wsport

esfServer.run()