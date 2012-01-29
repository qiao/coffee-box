exports.getCommentsController = (app) ->

  {Post}                     = app.settings.models
  {markdown}                 = app.settings.utils
  {sanitize}                 = require 'sanitizer'
  {postPath, commentsAnchor} = app.settings.helpers

  return {

    # POST /year/month/day/:slug/comments
    create: (req, res, next) ->
      Post.findBySlug req.params.slug, (err, post) ->
        return res.redirect '400' if err?
        return res.redirect '404' unless post?

        comment = req.body.comment

        # for all comments not submitted via AJAX, we consider that
        # it's submitter by spammers. this works for over 99% of the cases.
        # and for those innocent hams, they have a chance to be reviewed by 
        # blog owner and mark as `not spam`.
        # so why bother using akismet :p
        spam = not req.xhr
        comment.spam = spam

        # save comment 
        post.comments.push(comment)
        post.save (err) ->
          if req.xhr then createXhr() else createNormal()

        # helper function for creating comment with xhr
        createXhr = (err) ->
          res.partial 'comments/comment'
            post: post
            comment: post.comments[post.comments.length - 1]

        # helper function for creating comment without xhr
        createNormal = (err) ->
          if err
            req.flash 'error', err
            res.redirect 'back'
          else
            return req.flash 'error', 'your comment is pending for review' if spam?
            req.flash 'info', 'successfully posted'
            res.redirect postPath(post)

    # DEL /year/month/day/:slug/comments/:id
    destroy: (req, res, next) ->
      Post.findBySlug req.params.slug, (err, post) ->
        return res.redirect '400' if err?
        return res.redirect '404' unless post?
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
