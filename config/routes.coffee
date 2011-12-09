postController = require '../app/controllers/post_controller'

module.exports = (app) ->
  app.get '/',                     postController.index

  app.get '/posts/new.:format?',   postController.new
  app.get '/posts.:format?',       postController.index
  app.get '/posts/:slug.:format?', postController.show
