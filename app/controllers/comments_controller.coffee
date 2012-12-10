exports.getCommentsController = (app) ->

  {Post}                     = app.settings.models
  {markdown}                 = app.settings.utils
  {postPath, commentsAnchor} = app.settings.helpers
  {sanitize}                 = require 'validator'

  return {

    # POST /year/month/day/:slug/comments
    create: (req, res, next) ->
      Post.findBySlug req.params.slug, (err, post) ->
        return next err if err
        return res.send 404 unless post
        post.comments.push req.body.comment
        post.save (err) ->
          return next err if err
          res.redirect 'back'

    # DEL /year/month/day/:slug/comments/:id
    destroy: (req, res, next) ->
      Post.findBySlug req.params.slug, (err, post) ->
        return next err if err
        return res.redirect '404' unless post
        post.comments.id(req.params.id).remove()
        post.save (err) ->
          return next err if err
          res.redirect 'back'

    # POST /comments/preview
    preview: (req, res, next) ->
      markdown req.body.rawContent or '', (html) ->
        res.send sanitize(html).xss(), 200

    mark: (req, res, next) ->
      Post.markAllAsRead (err) ->
        res.redirect 'back'
  }
