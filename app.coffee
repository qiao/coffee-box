# Module dependencies

express = require 'express'
routes = require './routes'

app = module.exports = express.createServer()

# Configuration

app.configure ->
  app.set 'views', "#{__dirname}/views"
  app.set 'view engine', 'jade'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static("#{__dirname}/public")

app.configure 'development', ->
  app.use express.errorHandler(dumpException: true, showStack: true)

app.configure 'production', ->
  app.use express.errorHandler()

# Routes

app.get '/', routes.index

app.listen 3000
console.log "Express server listening on port #{app.address().port}
 in #{app.settings.env} mode"
