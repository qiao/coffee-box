Post = require('../models/post').Post
postPath = require('../helpers/posts_helper').postPath
markdown = require('../../lib/markdown').Markdown

CommentsController =
  # POST /year/month/day/:slug/comments
  create: (req, res, next) ->
    post = Post.findOne slug: req.params.slug, (err, post) ->
      if post
        comment = req.body.comment
        comment.content = markdown comment.raw_comment
        post.comments.push comment
        post.save (err) ->
          if err
            req.flash err
            res.redirect 'back'
          else
            req.info 'successfully posted'
            res.redirect postPath(post)
      else
        res.redirect '404'
