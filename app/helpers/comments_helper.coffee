moment = require 'moment'
gravatar = require 'gravatar'

module.exports =
  gravatarUrl: (comment) ->
    gravatar.url comment.email, size: '32', default: 'mm'

  commentMeta: (comment) ->
    moment(comment.createdAt).format 'YYYY-MM-DD hh:mm'

  commentAnchor: (comment) ->
    "#{comment._id}"

  commentsAnchor: (posts) ->
    "#comments-#{post._id}"

  commentDate: (comment) ->
    moment(comment.createdAt).format 'YYYY-MM-DD'
