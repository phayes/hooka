# Load in requirements
global.http = require 'http'
global.fs = require 'fs'
global.url = require 'url'
global.mongoose = require 'mongoose'

# Build the skeletal-hooka runtime object
global.hooka = 
  config: JSON.parse fs.readFileSync 'config/default.json'
  mod: {}
  hook: {}
  util: {}
  eph: {}
  
# Manually load in the minimun number of core utility functions required to continue the bootstrap process
global.hooka.util.core = {}
# global.hooka.utils.core.merge = require('./includes/utils.core.merge.coffee').merge
global.hooka.util.core.inc = require('./includes/util.core.inc.coffee').inc

# Load in the rest of the core utility functions
global.hooka.util.core.inc.dir ('includes')

# Set-up the server
http.createServer( (req, res) ->
  global.hooka.util.core.route(req, res)
).listen hooka.config.server.port

console.log "Server running at http://127.0.0.1:" + hooka.config.server.port
