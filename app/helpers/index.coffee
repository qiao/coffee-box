# auto load and register all helpers
fs   = require 'fs'
path = require 'path'

module.exports = (app) ->
  helpers = {}
  for filename in fs.readdirSync __dirname
    if path.extname(filename) is '.coffee' and
        path.resolve(filename) isnt __filename
      for k, v of require path.resolve path.join __dirname, filename
        helpers[k] = v
  app.helpers helpers
