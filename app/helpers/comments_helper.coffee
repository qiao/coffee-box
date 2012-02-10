moment = require 'moment'
gravatar = require 'gravatar'

module.exports =
  gravatarUrl: (comment) ->
    gravatar.url comment.email, size: '32', default: 'mm'

  commentMeta: (comment) ->
    moment(comment.createdAt).format 'YYYY-MM-DD hh:mm'

  commentAnchor: (comment) ->
    "#{comment._id}"

  commentsAnchor: (post) ->
    "#comments-#{post._id}"

  commentDate: (comment) ->
    moment(comment.createdAt).format 'YYYY-MM-DD'

  commentWebsite: (comment) ->
    website = comment.website
    website = "http://#{website}" unless /^https?:\/\//.test website
