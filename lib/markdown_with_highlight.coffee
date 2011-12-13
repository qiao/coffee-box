markdown  = require('node-markdown').Markdown
highlight = require('highlight').Highlight

exports.MarkdownWithHighlight = (raw) ->
  highlight markdown(raw), false, true
