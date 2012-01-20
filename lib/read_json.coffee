fs = require('fs')

exports.readJson = (filename) ->
  JSON.parse(fs.readFileSync(filename))
