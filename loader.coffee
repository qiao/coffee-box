fs   = require 'fs'
path = require 'path'

module.exports = (app) ->
  loadHelpers app

# load and register all helpers in `./app/helpers`
loadHelpers = (app) ->

  HELPERS_PATH = './app/helpers'
  helpers = {}

  fs.readdir HELPERS_PATH, (err, filenames) ->
    filenames.forEach (filename) ->
      if path.extname(filename) is '.coffee'
        for k, v of require path.resolve path.join HELPERS_PATH, filename
          helpers[k] = v

    app.helpers helpers
