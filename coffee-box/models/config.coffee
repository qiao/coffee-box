async    = require 'async'
mongoose = require 'mongoose'
Schema   = mongoose.Schema
path     = require 'path'
assets   = require 'connect-assets'
express  = require 'express'

ConfigSchema = new Schema
  sitename:
    type: String
    default: 'Another nodlog'
  description:
    type: String
    default: 'hello, nodlog!'
  author:
    type: String
    default: 'unamed hero'
  theme:
    type: String
    default: 'default'

ConfigSchema.statics.Load = (callback) ->
  query = {}
  @findOne query, (err,config)->
    callback err,config||new Config

ConfigSchema.methods.Apply = (app) ->
  themePath = path.join __dirname,'..','..','themes',this.theme
  app.set 'assetsRoute', assets
    src: path.join themePath,'assets'
    build: true
    detectChanges: false
    buildDir: false
  app.set 'publicRoute', express.static path.join themePath,'public'
  app.set 'views', path.join themePath,'views'

Config = mongoose.model 'Config', ConfigSchema

module.exports =
  ConfigSchema: ConfigSchema
  Config:       Config
