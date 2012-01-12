site = require('../../config/site')
openid = require('openid')

relyingParty = new openid.RelyingParty(
    site.url + '/verify' # verification url
  , null                 # realm
  , false                # use stateless verification
  , []                   # extensions
  )

module.exports = SessionController =
  # GET /login
  new: (req, res, next) ->
    res.render 'session/new'

  # POST /login
  create: (req, res, next) ->
    id = req.body.id
    relyingParty.authenticate id, false, (error, authUrl) ->
      if error
        res.send 'Authentication failed: ' + error.message, 200
      else if !authUrl
        res.send 'Authentication failed', 200
      else
        res.redirect authUrl

  # GET /verify
  verify: (req, res, next) ->
    message = ''
    relyingParty.verifyAssertion req, (error, result) ->
      if error
        message = error
      else
        if result.authenticated
          if result.claimedIdentifier in site.openIds
            req.session.loggedIn = true
            return res.redirect '/admin'
          else
            message = 'account not in admin list'
      res.send 'Authentication failed: ' + message


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
