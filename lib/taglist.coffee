exports.makeTagList = (str) ->
  str
    .replace(/\s+/g, ',')
    .split(',')
    .map (s) ->
      s.trim()
    .filter (s) ->
      s.length
