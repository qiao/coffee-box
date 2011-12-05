postController = require '../app/controllers/post'

module.exports = (app) ->
  app.get '/', postController.index
