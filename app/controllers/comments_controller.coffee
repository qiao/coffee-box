exports.getCommentsController = (app) ->

  {Post}                     = app.settings.models
  {markdown}                 = app.settings.utils
  {sanitize}                 = require 'sanitizer'
  {postPath, commentsAnchor} = app.settings.helpers

  return {

    # POST /year/month/day/:slug/comments
    create: (req, res, next) ->
      # only allow comments created by ajax requests
      return res.send 400 unless req.xhr

      Post.findBySlug req.params.slug, (err, post) ->
        return res.send 400 if err
        return res.send 404 unless post
        post.comments.push req.body.comment
        post.save (err) ->
          return res.send(err, 400) if err
          res.partial 'comments/comment'
            post: post
            comment: post.comments[post.comments.length - 1]

    # DEL /year/month/day/:slug/comments/:id
    destroy: (req, res, next) ->
      Post.findBySlug req.params.slug, (err, post) ->
        return res.redirect '400' if err
        return res.redirect '404' unless post
        post.comments.id(req.params.id).remove()
        post.save (err) ->
          if req.xhr
            res.send 200
          else
            res.redirect postPath(post) + commentsAnchor(post)
   
    # POST /comments/preview
    preview: (req, res, next) ->
      markdown req.body.rawContent or '', (html) ->
        res.send sanitize(html), 200
  }
