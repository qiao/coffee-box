express  = require 'express'
mongoose = require 'mongoose'
stylus   = require 'stylus'

rootdir = "#{__dirname}/.."

module.exports = (app) ->
  app.configure ->
    app.set 'views', "#{rootdir}/app/views"
    app.set 'view engine', 'jade'
    app.set 'view options', layout: "#{rootdir}/app/views/layouts/layout"
    app.use stylus.middleware(src: "#{rootdir}/public")
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser()
    app.use express.session(secret: 'secret token')
    app.use express.logger('dev')
    app.use app.router
    app.use express.static("#{rootdir}/public")

  app.configure 'development', ->
    app.use express.errorHandler(dumpException: true, showStack: true)

  app.configure 'production', ->
    app.use express.errorHandler()

  mongoose.connect 'mongodb://localhost/coffee-box-db'
