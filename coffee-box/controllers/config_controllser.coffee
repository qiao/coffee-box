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
          config.Apply app
          req.flash 'info', 'successfully changed'
          res.redirect 'back'
  }
