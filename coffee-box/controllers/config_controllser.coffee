exports.getConfigController = (app) ->
  path                        = require 'path'
  {Config}                    = app.settings.models
  return {
    # POST /config
    change: (req, res, next) ->
      Config.Load (err, config) ->
        return res.send err,500 if err
        config[k]=v for k,v of req.body.config
        config.save (err) ->
          return res.send(err, 500) if err
          app.locals[k]=v for k,v of config
          app.set 'views', path.join __dirname,'..','..','themes',config.theme,'views'
          req.flash 'info', 'successfully changed'
          res.redirect 'back'
  }
