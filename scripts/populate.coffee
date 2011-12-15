#!/usr/bin/env coffee
# Populate database with faked data

DB_URL   = 'mongodb://localhost/coffee-box-db'

Post     = require('../app/models/post').Post
Faker    = require 'Faker'
mongoose = require 'mongoose'
markdown = require('../lib/markdown').Markdown

mongoose.connect DB_URL
console.log 'connected to db'


for i in [1..20]
  post = {}
  post.title       = Faker.Lorem.sentence()
  post.slug        = Faker.Lorem.words(3).join '-'
  post.raw_content = Faker.Lorem.paragraphs(4)
  post.content     = markdown post.raw_content
  post.asPage      = i > 19

  comments = []
  numComments = Math.round(Math.random() * 5)
  for j in [1..numComments]
    comment = {}
    comment.name        = Faker.Name.firstName()
    comment.email       = Faker.Internet.email()
    comment.website     = Faker.Internet.domainName()
    comment.raw_content = Faker.Lorem.paragraphs(2)
    comment.content     = markdown comment.raw_content
    comments.push comment
  post.comments = comments
  (new Post(post)).save()


console.log 'done'
mongoose.disconnect()
console.log 'dis'
