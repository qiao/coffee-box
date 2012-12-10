async    = require 'async'
mongoose = require 'mongoose'
Schema   = mongoose.Schema

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

Config = mongoose.model 'Config', ConfigSchema

module.exports =
  ConfigSchema: ConfigSchema
  Config:       Config
