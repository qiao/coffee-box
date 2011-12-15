password = require('../../config/site').password

SessionController =
  # GET /login
  new: (req, res, next) ->
    res.render 'session/new'

  # POST /login
  create: (req, res, next) ->
    if req.body.password is password
      req.session.loggedIn = true
      res.redirect '/admin'
    else
      req.flash 'error', 'Wrong password'
      res.redirect 'back'

  # GET /logout
  destroy: (req, res, next) ->
    req.session.destroy (err) ->
      res.redirect 'home'

  # middleware for requiring login
  requireLogin: (req, res, next) ->
    if req.session.loggedIn
      next()
    else
      res.redirect '/login'

module.exports = SessionController
