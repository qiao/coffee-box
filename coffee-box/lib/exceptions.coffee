module.exports = (err,req,res,next)->
  if err
    return res.send 500,err.message if req.xhr
    req.flash 'error',err.message
    return res.redirect 'back' if req.method=='POST'
  next(err)