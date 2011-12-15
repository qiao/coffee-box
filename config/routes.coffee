PostsController     = require '../app/controllers/posts_controller'
CommentsController  = require '../app/controllers/comments_controller'
SessionController   = require '../app/controllers/session_controller'
DashboardController = require '../app/controllers/dashboard_controller'

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
COMMENT_DELETE_PATTEN = COMMENT_CREATE_PATTEN + '/:id'

# middleware to find all posts published as individual pages
findPages = PostsController.findPages

module.exports = (app) ->
  app.get '/'                    , findPages   , PostsController.index

  app.get  '/posts.:format?'     , findPages   , PostsController.index
  app.get  POST_SHOW_PATTERN     , findPages   , PostsController.show
  app.get  '/posts/new.:format?' , findPages   , PostsController.new
  app.get  POST_EDIT_PATTERN     , findPages   , PostsController.edit
  app.post '/posts.:format?'                   , PostsController.create
  app.put  POST_SHOW_PATTERN                   , PostsController.update
  app.del  POST_SHOW_PATTERN                   , PostsController.delete

  app.post COMMENT_CREATE_PATTEN               , CommentsController.create
  app.post COMMENT_DELETE_PATTEN               , CommentsController.destroy

  app.get  '/login'              , findPages   , SessionController.new
  app.post '/login'                            , SessionController.create
  app.get  '/logout'                           , SessionController.destroy

  app.get  '/admin'              , findPages   , DashboardController.index

  app.get  '/:slug.:format?'     , findPages   , PostsController.showPage

  app.redirect '404'             , '/404.html'
  app.redirect '500'             , '/500.html'
