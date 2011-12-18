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
            if req.xhr
              res.send err, 400
            else
              req.flash 'error', err
              res.redirect 'back'
          else
            if req.xhr
              res.partial 'comments/comment', comment: comment
            else
              req.flash 'info', 'successfully posted'
              res.redirect postPath(post) + '#comments'
      else
        res.send 'Requested post doesn\'t exist', 400

  # DEL /year/month/day/:slug/comments/:id
  destroy: (req, res, next) ->
    post = Post.findOne slug: req.params.slug, (err, post) ->
      if post
        post.comments.id(req.params.id).remove()
        post.save (err) ->
          if err
            res.send err, 400
          else
            if req.xhr
              res.send 'ok', 200
            else
              res.redirect postPath(post) + '#comments'
      else
        res.send 'Requested post doesn\'t exist', 400
    
module.exports = CommentsController
