PostsController = require '../app/controllers/posts_controller'
CommentsController = require '../app/controllers/comments_controller'

# match post against /year/month/day/:slug.:format?
# it seems to be a bug that expressjs doesn't support the /\d/ regexp.
POST_PATTERN =
  '/:year([0-9]{4})' +
  '/:month([0-9]{2})'+
  '/:day([0-9]{2})' +
  '/:slug'
POST_SHOW_PATTERN = POST_PATTERN + '.:format?'
POST_EDIT_PATTERN = POST_PATTERN + '/edit/.:format?'
COMMENT_CREATE_PATTEN = POST_PATTERN + '/comments'


module.exports = (app) ->
  app.get '/',                      PostsController.index

  app.get  '/posts.:format?',       PostsController.index
  app.get  POST_SHOW_PATTERN,       PostsController.show
  app.get  '/posts/new.:format?',   PostsController.new
  app.get  POST_EDIT_PATTERN,       PostsController.edit
  app.post '/posts.:format?',       PostsController.create
  app.put  POST_SHOW_PATTERN,       PostsController.update
  app.del  POST_SHOW_PATTERN,       PostsController.delete

  app.post COMMENT_CREATE_PATTEN,   CommentsController.create


  app.redirect '404', '/404.html'
  app.redirect '500', '/500.html'
