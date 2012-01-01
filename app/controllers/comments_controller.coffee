Post = require('../models/post').Post
postsHelper = require('../helpers/posts_helper')
commentsHelper = require('../helpers/comments_helper')
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
              res.send 400
            else
              req.flash 'error', err
              res.redirect 'back'
          else
            if req.xhr
              res.partial 'comments/comment'
                post: post
                comment: post.comments[post.comments.length - 1]
            else
              req.flash 'info', 'successfully posted'
              res.redirect postsHelper.postPath(post) +
                           commentsHelper.commentsAnchor(post)
      else
        res.send 400

  # DEL /year/month/day/:slug/comments/:id
  destroy: (req, res, next) ->
    post = Post.findOne slug: req.params.slug, (err, post) ->
      if post
        post.comments.id(req.params.id).remove()
        post.save (err) ->
          if err
            res.send 400
          else
            if req.xhr
              res.send 200
            else
              res.redirect postsHelper.postPath(post) +
                           commentsHelper.commentsAnchor(post)
      else
        res.send 400
 
  # POST /comments/preview
  preview: (req, res, next) ->
    try
      res.send markdown(req.body.raw_content), 200
    catch error
      res.send 400

module.exports = CommentsController
