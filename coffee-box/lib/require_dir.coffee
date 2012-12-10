# require all `.coffee` files in a directory and export in a bundle
fs   = require 'fs'
path = require 'path'

exports.requireDir = (dirname) ->
  bundle = {}
  for filename in fs.readdirSync dirname
    if path.extname(filename) is '.js'
      for k, v of require path.resolve(path.join(dirname, filename))
        bundle[k] = v
  bundle
