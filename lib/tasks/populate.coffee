Post     = require('../../app/models/post').model
Faker    = require 'Faker'
mongoose = require 'mongoose'
markdown = require('../markdown_with_highlight').MarkdownWithHighlight

exports.populate = (dbUrl) ->
  for i in [1..20]
    title       = Faker.Lorem.sentence()
    raw_content = Faker.Lorem.paragraphs(4)
    content     = markdown raw_content
    slug        = Faker.Lorem.words(3).join '-'
    (new Post
      title: title
      raw_content: raw_content
      content: content
      slug: slug
      createdAt: new Date
      updatedAt: new Date).save()

  mongoose.connect dbUrl
