postController = require '../app/controllers/post_controller'

module.exports = (app) ->
  app.get '/',           postController.index

  app.get '/posts',      postController.index
  app.get '/posts/:slug', postController.show
