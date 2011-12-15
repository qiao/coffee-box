moment = require 'moment'

module.exports =
  postPath: (post) ->
    date = moment(post.createdAt).format 'YYYY/MM/DD'
    "/#{date}/#{post.slug}"

  postDate: (post) ->
    moment(post.createdAt).format 'YYYY-MM-DD'

  postTime: (post) ->
    moment(post.createdAt).format 'hh:mm'

  postDay: (post) ->
    moment(post.createdAt).format 'DD'

  postMonth: (post) ->
    moment(post.createdAt).format 'MMM'
