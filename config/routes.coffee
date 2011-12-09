PostsController = require '../app/controllers/posts_controller'

# match post against /year/month/day/:slug.:format?
# it seems to be a bug that expressjs doesn't support the /\d/ regexp.
POST_PATTERN =
  '/:year([0-9]{4})' +
  '/:month([0-9]{2})'+
  '/:day([0-9]{2})' +
  '/:slug.:format?'

module.exports = (app) ->
  app.get '/',                     PostsController.index

  app.get '/posts.:format?',       PostsController.index
  app.get POST_PATTERN,            PostsController.show
  app.get '/posts/new.:format?',   PostsController.new
