exports.makeTagList = (str) ->
  str
    .replace(/\s+/g, ',')
    .split(',')
    .filter (s) ->
      s.length
