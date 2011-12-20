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

# middleware for finding all posts published as individual pages
findPages = PostsController.findPages
# middleware for requiring login
requireLogin = SessionController.requireLogin

module.exports = (app) ->
  app.get '/'                    , findPages                , PostsController.index

  app.get  '/posts.:format?'     , findPages                , PostsController.index
  app.get  POST_SHOW_PATTERN     , findPages                , PostsController.show
  app.get  '/posts/new.:format?' , requireLogin , findPages , PostsController.new
  app.get  POST_EDIT_PATTERN     , requireLogin , findPages , PostsController.edit
  app.post '/posts.:format?'     , requireLogin             , PostsController.create
  app.put  POST_SHOW_PATTERN     , requireLogin             , PostsController.update
  app.del  POST_SHOW_PATTERN     , requireLogin             , PostsController.destroy

  app.post COMMENT_CREATE_PATTEN                            , CommentsController.create
  app.del  COMMENT_DELETE_PATTEN , requireLogin             , CommentsController.destroy
  app.post '/comments/preview'                              , CommentsController.preview

  app.get  '/login'              , findPages                , SessionController.new
  app.post '/login'                                         , SessionController.create
  app.get  '/logout'                                        , SessionController.destroy

  app.get  '/admin'              , requireLogin , findPages , DashboardController.index

  app.get  '/feed'                                          , PostsController.feed

  app.get  '/:slug.:format?'     , findPages                , PostsController.showPage

  app.redirect '404'             , '/404.html'
  app.redirect '500'             , '/500.html'
