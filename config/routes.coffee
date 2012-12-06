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


module.exports = (app) ->
  
  # get controllers from app settings
  controllersGetter    = app.settings.controllersGetter
  PostsController      = controllersGetter.getPostsController     app
  CommentsController   = controllersGetter.getCommentsController  app
  SessionController    = controllersGetter.getSessionController   app
  DashboardController  = controllersGetter.getDashboardController app
  ConfigController     = controllersGetter.getConfigController    app

  # middleware for finding all posts published as individual pages
  findPages = PostsController.findPages
  # middleware for requiring login
  requireLogin = SessionController.requireLogin

  app.get '/'                    , findPages                , PostsController.index

  app.get  '/posts.:format?'     , findPages                , PostsController.index
  app.get  POST_SHOW_PATTERN     , findPages                , PostsController.show
  app.get  '/posts/new.:format?' , requireLogin , findPages , PostsController.new
  app.get  POST_EDIT_PATTERN     , requireLogin , findPages , PostsController.edit
  app.post '/posts.:format?'     , requireLogin             , PostsController.create
  app.put  POST_SHOW_PATTERN     , requireLogin             , PostsController.update
  app.del  POST_SHOW_PATTERN     , requireLogin             , PostsController.destroy
  app.post '/posts/preview'                                 , PostsController.preview

  app.post COMMENT_CREATE_PATTEN                            , CommentsController.create
  app.del  COMMENT_DELETE_PATTEN , requireLogin             , CommentsController.destroy
  app.post '/comments/preview'                              , CommentsController.preview
  app.put  '/mark-all-as-read'   , requireLogin             , CommentsController.mark

  app.get  '/login'              , findPages                , SessionController.new
  app.post '/login'                                         , SessionController.create
  app.get  '/logout'                                        , SessionController.destroy
  app.get  '/verify'                                        , SessionController.verify

  app.get  '/admin/*'            , requireLogin , findPages
  app.get  '/admin/'                                        , DashboardController.index
  app.get  '/admin/posts'                                   , DashboardController.posts
  app.get  '/admin/comments'                                , DashboardController.comments
  app.get  '/admin/config'                                  , DashboardController.config
  app.get  '/admin/new-post'                                , DashboardController.newPost

  app.post '/config/'            , requireLogin             , ConfigController.change

  app.get  '/feed'                                          , PostsController.feed

  app.get  '/:slug.:format?'     , findPages                , PostsController.showPage

  # app.redirect '404'             , '/404.html'
  # app.redirect '500'             , '/500.html'
