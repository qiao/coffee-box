PostsController = require '../app/controllers/posts_controller'

POST_PATTERN = /^\/\d{4}\d{2}\d{2}\/(?:\s+)(.?(?:\s+))$/

module.exports = (app) ->
  app.get '/',                     PostsController.index

  app.get '/posts/new.:format?',   PostsController.new
  app.get '/posts.:format?',       PostsController.index
  app.get POST_PATTERN,            PostsController.show
  app.get '/posts/:slug.:format?', PostsController.show
