# Load in requirements
http = require 'http'
fs = require 'fs'
url = require 'url'

# Build the skeletal-hooka runtime object
global.hooka = 
  config: JSON.parse fs.readFileSync 'config/default.json'
  routers: {}
  modifiers: {}
  hooks: {}
  utils: {}
  
# TODO load this in via fs include dir
global.hooka.utils.bootstrap = require('./includes/hooka.utils.bootstrap.coffee').bootstrap
global.hooka.utils.route = require('./includes/hooka.utils.route.coffee').route

# Set-up the server
http.createServer( (req, res) ->
  global.hooka.utils.route(req, res)
).listen hooka.config.server.port

console.log "Server running at http://127.0.0.1:" + hooka.config.server.port
