moment = require 'moment'
gravatar = require 'gravatar'

module.exports =
  gravatarUrl: (comment) ->
    gravatar.url comment.email, size: '32', default: 'mm'

  commentMeta: (comment) ->
    moment(comment.createdAt).format 'YYYY-MM-DD hh:mm'

  commentsAnchor: (post) ->
    "#comments-#{post._id}"
