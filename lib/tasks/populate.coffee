Post     = require('../../app/models/post').model
Faker    = require 'Faker'
mongoose = require 'mongoose'

exports.populate = (dbUrl) ->
  for i in [1..20]
    title = Faker.Lorem.sentence()
    body = Faker.Lorem.paragraphs(4)
    slug = Faker.Lorem.words(3).join '-'
    (new Post title: title, body: body, slug: slug, createdAt: new Date, updatedAt: new Date).save()

  mongoose.connect dbUrl
