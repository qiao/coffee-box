express   = require 'express'
assets    = require 'connect-assets'
mongoose  = require 'mongoose'
stylus    = require 'stylus'
ecoffee   = require 'express-coffee'
bootstrap = require 'bootstrap-stylus'

ROOT_DIR = "#{__dirname}/.."
DB_PATH  = 'mongodb://localhost/coffee-box-db'

stylusMid = stylus.middleware
  src     : "#{ROOT_DIR}/public"
  compile : (str, path) ->
              stylus(str)
                .set('filename', path)
                .set('compress', true)
                .use(bootstrap())

module.exports = (app) ->
  app.configure ->
    app.set 'views', "#{ROOT_DIR}/app/views"
    app.set 'view engine', 'jade'
    app.set 'view options', layout: "#{ROOT_DIR}/app/views/layouts/layout"
    app.use stylusMid
    #app.use ecoffee(path: "#{ROOT_DIR}/public", live: !process.env.PRODUCTION, uglify: true)
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser()
    app.use express.session(secret: 'secret token')
    app.use express.logger('dev')
    app.use assets(build: true)
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
