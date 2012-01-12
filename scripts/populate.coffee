#!/usr/bin/env coffee
# Populate database with faked data

DB_URL   = 'mongodb://localhost/coffee-box-db'

Post     = require('../app/models/post').Post
Faker    = require 'Faker'
mongoose = require 'mongoose'
markdown = require('../lib/markdown').Markdown

mongoose.connect DB_URL

savedNum = 0

for i in [1..20]
  post = {}
  post.title       = Faker.Lorem.sentence()
  post.slug        = Faker.Lorem.words(3).join '-'
  post.rawContent = Faker.Lorem.paragraphs(4)
  post.content     = markdown post.rawContent
  post.asPage      = i > 17
  if post.asPage
    post.title = post.title.slice(0, 5)

  comments = []
  numComments = Math.round(Math.random() * 5)
  for j in [1..numComments]
    comment = {}
    comment.name        = Faker.Name.firstName()
    comment.email       = Faker.Internet.email()
    comment.website     = Faker.Internet.domainName()
    comment.rawContent = Faker.Lorem.paragraphs(2)
    comment.content     = markdown comment.rawContent
    comments.push comment
  post.comments = comments

  (new Post(post)).save ->
    savedNum += 1
    if savedNum is 20
      mongoose.disconnect()
      process.exit()
