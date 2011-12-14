$ ->
  # highlight codes
  $('pre code').each (i, e) ->
    hljs.highlightBlock e, '    '
