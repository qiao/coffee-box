fs        = require 'fs'
express   = require 'express'
assets    = require 'connect-assets'
mongoose  = require 'mongoose'

ROOT_DIR = "#{__dirname}/.."

module.exports = (app) ->
  app.configure ->
    app.set 'views', "#{ROOT_DIR}/app/views"
    app.set 'view engine', 'jade'
    app.set 'view options', layout: "#{ROOT_DIR}/app/views/layouts/layout"
    app.use express.logger('dev')
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser()
    app.use express.session(secret: 'secret token')
    app.use assets(src: 'app/assets', build: true, detectChanges: false, buildDir: false)
    app.use express.static("#{ROOT_DIR}/public")
    app.use app.router
    app.set 'version', JSON.parse(fs.readFileSync("#{ROOT_DIR}/package.json")).version
    app.set k, v for k, v of JSON.parse(fs.readFileSync("#{ROOT_DIR}/config/site.json"))
    app.dynamicHelpers messages: require('express-messages')
    app.dynamicHelpers session: (req, res) -> req.session

  app.configure 'development', ->
    app.use express.errorHandler(dumpException: true, showStack: true)

  app.configure 'production', ->
    app.use express.errorHandler()

  mongoose.connect app.settings.dbpath, (err) ->
    if err
      console.log err
      process.exit()
