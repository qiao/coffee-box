async    = require('async')
marked = require('marked')
pygments = require('pygments')

highlight = (token, callback) ->
  if token.type is 'code' and token.lang
    pygments.colorize token.text, token.lang, 'html', (data) ->
      token.text = data
      token.type = 'html'
      token.escaped = true
      callback()
  else
    callback()

markdown = (text, colorize, callback) ->
  tokens = marked.lexer text
  if colorize
    async.forEach tokens, highlight, ->
      html = marked.parser tokens
      callback html
  else
    callback marked.parse(text)

exports.markdown = (text, callback) ->
  markdown text, true, callback
