# Get home page
exports.index = (req, res) ->
  res.render 'index', title: 'Express'
