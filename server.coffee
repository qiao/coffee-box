express = require 'express'
app = module.exports = express.createServer()

require('./config/config') app
require('./config/routes') app
require('./app/helpers')   app

app.listen 3000
console.log "coffee-box server listening on port #{app.address().port} " +
  "in #{app.settings.env} mode"
