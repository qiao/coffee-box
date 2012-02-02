#!/usr/bin/env coffee
# Populate database with faked data

DB_URL     = 'mongodb://localhost/coffee-box-db'

async      = require 'async'
mongoose   = require 'mongoose'
Faker      = require 'Faker'
{Post}     = require '../app/models/post'

mongoose.connect DB_URL

populatePost = (index, callback) ->
  post = {}
  post.title       = Faker.Lorem.sentence()
  post.slug        = Faker.Lorem.words(3).join '-'
  post.rawContent  = Faker.Lorem.paragraphs(4)
  post.asPage      = index > 17
  if post.asPage
    post.title = post.title.slice(0, 5)

  comments = []
  numComments = Math.round(Math.random() * 5)
  for j in [1..numComments]
    comment = {}
    comment.name        = Faker.Name.firstName()
    comment.email       = Faker.Internet.email()
    comment.website     = Faker.Internet.domainName()
    comment.rawContent  = Faker.Lorem.paragraphs(2)
    comment.spam        = Math.random() > 0.7
    comment.read        = false
    comments.push comment
  post.comments = comments

  (new Post(post)).save (err)->
    callback err

async.forEach [1..20], populatePost, (err) ->
  console.log err if err
  mongoose.disconnect()
  process.exit()
