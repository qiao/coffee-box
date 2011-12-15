Post = require('../models/post').Post
postPath = require('../helpers/posts_helper').postPath
markdown = require('../../lib/markdown').Markdown

CommentsController =
  # POST /year/month/day/:slug/comments
  create: (req, res, next) ->
    post = Post.findOne slug: req.params.slug, (err, post) ->
      if post
        comment = req.body.comment or {}
        comment.content = markdown(comment.raw_content or '')
        post.comments.push comment
        post.save (err) ->
          if err
            req.flash 'error', err
            res.redirect 'back'
          else
            req.flash 'info', 'successfully posted'
            res.redirect postPath(post)
      else
        res.redirect '404'

  # DEL /year/month/day/:slug/comments/:id
  destroy: (req, res, next) ->
    post = Post.findOne slug: req.params.slug, (err, post) ->
      if post
        post.comments.id(id).remove()
        post.save (err) ->
          # comment removed
    
module.exports = CommentsController
