moment = require 'moment'
gravatar = require 'gravatar'

module.exports =
  gravatarUrl: (comment) ->
    gravatar.url comment.email, size: '32'

  commentMeta: (comment) ->
    moment(comment.createdAt).format 'YYYY-MM-DD hh:mm'
