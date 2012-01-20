markdown = require('node-markdown').Markdown

autolink = (html) ->
  # Auto-link URLs and emails (modified based on github-flavored-markdown)
  html = html.replace /https?\:\/\/[^"\s\<\>]*[^.,;'">\:\s\<\>\)\]\!]/g, (wholeMatch,matchIndex) ->
    left = html.slice(0, matchIndex)
    right = html.slice(matchIndex)

    if left.match(/<[^>]+$/) and right.match(/^[^>]*>/)
      return wholeMatch
    '<a href="' + wholeMatch + '">' + wholeMatch + '</a>'

  html.replace /[a-z0-9_\-+=.]+@[a-z0-9\-]+(\.[a-z0-9-]+)+/ig, (wholeMatch) ->
    '<a href="mailto:' + wholeMatch + '">' + wholeMatch + '</a>'


exports.markdown = (raw) ->
  html = markdown raw, true # filter html tags
  autolink html
