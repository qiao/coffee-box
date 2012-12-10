exports.getConfigController = (app) ->
  {Config}                    = app.settings.models
  return {
    # POST /config
    change: (req, res, next) ->
      Config.Load (err, config) ->
        return res.send err,500 if err
        config[k]=v for k,v of req.body.config
        config.save (err) ->
          return res.send(err, 500) if err
          app.set k,v for k,v of config
          req.flash 'info', 'successfully changed'
          res.redirect 'back'
  }
