exports.getSessionController = (app) ->
  exceptions = require '../../lib/exceptions'
  openid = require('openid')
  relyingParty = new openid.RelyingParty(
      app.settings.url + '/verify' # verification url
    , null                         # realm
    , false                        # use stateless verification
    , []                           # extensions
    )

  return {

    # GET /login
    new: (req, res, next) ->
      res.render 'session/new'

    # POST /login
    create: (req, res, next) ->
      # don't auth with OpenID if in dev mode
      if app.settings.env is 'development'
        req.session.loggedIn = true
        return res.redirect '/admin'
      
      id = req.body.id
      relyingParty.authenticate id, false, (error, authUrl) ->
        if error or not authUrl
          req.flash 'error', exceptions.getMessage error
          return res.redirect '/login'
        res.redirect authUrl

    # GET /verify
    verify: (req, res, next) ->
      message = ''
      relyingParty.verifyAssertion req, (error, result) ->
        if error
          message = error
        else
          if result.authenticated
            if result.claimedIdentifier is app.settings.openId
              req.session.loggedIn = true
              return res.redirect '/admin'
            else
              message = 'invalide account'
        req.flash 'error', message
        res.redirect '/login'


    # GET /logout
    destroy: (req, res, next) ->
      req.session.destroy (err) ->
        res.redirect 'home'

    # middleware for requiring login
    requireLogin: (req, res, next) ->
      return res.redirect '/login' unless req.session.loggedIn
      next()

  }
