postController = require './controllers/post'

module.exports = (app) ->
  app.get '/', postController.index
