express   = require 'express'
assets    = require 'connect-assets'
mongoose  = require 'mongoose'

ROOT_DIR = "#{__dirname}/.."
DB_PATH  = 'mongodb://localhost/coffee-box-db'

module.exports = (app) ->
  app.configure ->
    app.set 'views', "#{ROOT_DIR}/app/views"
    app.set 'view engine', 'jade'
    app.set 'view options', layout: "#{ROOT_DIR}/app/views/layouts/layout"
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser()
    app.use express.session(secret: 'secret token')
    app.use express.logger('dev')
    app.use assets(src: 'app/assets', build: true, detectChanges: false, buildDir: false)
    app.use express.static("#{ROOT_DIR}/public")
    app.use app.router
    app.set k, v for k, v of require('./site')
    app.dynamicHelpers messages: require('express-messages')
    app.dynamicHelpers session: (req, res) -> req.session

  app.configure 'development', ->
    app.use express.errorHandler(dumpException: true, showStack: true)

  app.configure 'production', ->
    app.use express.errorHandler()

  mongoose.connect DB_PATH
