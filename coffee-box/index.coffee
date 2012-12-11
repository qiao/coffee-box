express       = require 'express'
app           = module.exports = express()
flash         = require 'connect-flash'
assets        = require 'connect-assets'
mongoose      = require 'mongoose'
path          = require 'path'
jade          = require 'jade'
moment        = require 'moment'
{requireDir}  = require './lib/require_dir'

ROOT_DIR = path.join __dirname,'..'

app.configure ->
  app.set 'version', require("#{ROOT_DIR}/package.json").version
  app.set k, v for k, v of require("#{ROOT_DIR}/coffee-box.config.json")
  app.set 'utils', requireDir("#{ROOT_DIR}/coffee-box/lib")
  app.set 'models', requireDir("#{ROOT_DIR}/coffee-box/models")
  app.settings.models.Config.Load (err,config)->
    if err
      console.error err
      return process.exit 1
    config.Apply app
    
    
  app.locals.coffeeBox =
    version: app.settings.version
    nodejsVersion: process.version

  app.set 'controllersGetter', requireDir("#{ROOT_DIR}/coffee-box/controllers")
  app.set 'view engine','jade'
  app.engine 'jade',(p,options,cb)->
    # Express bound `settings` there, but we don't need it.
    options.settings = undefined

    options = JSON.parse JSON.stringify options
    options.moment = moment
    if app.settings.env=='development'
      options.templateData = JSON.stringify options,null,'  '
    jade.__express p,options,cb
  app.set 'views',"#{ROOT_DIR}"
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.session(secret: app.settings.secretKey)

  # Allow we to flash simple message like in express 2.x
  app.use flash()

  # Expose message and login state to templates
  app.use (req,res,next)->
    res.locals.loggedIn           = Boolean req.session.loggedIn
    res.locals.messages           = req.flash()
    res.locals.messages.error   ||= []
    res.locals.messages.info    ||= []
    next()

  app.set 'themeAssetsContext',{}
  app.set 'defaultAssetsContext',{}
  app.use assets
    src                     : path.join ROOT_DIR,'themes','default','assets'
    build                   : true
    detectChanges           : false
    buildDir                : false
    helperContext           : app.get 'defaultAssetsContext'
  app.use express.static path.join ROOT_DIR,'themes','default','public'

  app.use (req,res,next)-> app.get('assetsRoute') req,res,next
  app.use (req,res,next)-> app.get('publicRoute') req,res,next


  # Since express does not intend to implement multiple view path, we'll have to hack it
  # https://github.com/visionmedia/express/pull/1186
  app.use (req,res,next)->
    res.expressRender = res.render
    res.render  = (view,data)->
      viewPath = path.join('themes',app.locals.config.theme,'views',view)
      path.exists path.join(ROOT_DIR, viewPath+'.jade'),(exists)->
        try
          if !exists
            viewPath =  path.join('themes','default','views',view)
            res.locals.cssAssets = app.get('defaultAssetsContext').css('/stylesheets/application')
            res.locals.jsAssets = app.get('defaultAssetsContext').js('/javascripts/application')
          else
            res.locals.cssAssets = app.get('themeAssetsContext').css('/stylesheets/application')
            res.locals.jsAssets = app.get('themeAssetsContext').js('/javascripts/application')
        catch err
          return res.send '500',err.message
        res.expressRender viewPath,data
    next()


  app.use app.router
  app.use require './lib/exceptions'

app.configure 'development', ->
  app.use express.logger('dev')
  app.use express.errorHandler(dumpException: true, showStack: true)

app.configure 'production', ->
  app.use express.logger()
  app.use express.errorHandler()

mongoose.connect app.settings.dbpath, (err) ->
  if err
    console.error err
    return process.exit()
require('./routes') app
