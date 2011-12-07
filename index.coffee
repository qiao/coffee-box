express = require 'express'
app = module.exports = express.createServer()

require('./loader') app

unless module.parent
  app.listen 3000
  console.log "coffee-box server listening on port #{app.address().port} " +
    "in #{app.settings.env} mode"
