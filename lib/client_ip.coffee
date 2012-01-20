exports.getClientIp = (req) ->
  # The request may be forwarded from local web server.
  forwardedIpsStr = req.header('x-forwarded-for')
  if forwardedIpsStr
    # 'x-forwarded-for' header may return multiple IP addresses in
    # the format: "client IP, proxy 1 IP, proxy 2 IP" so take the
    # the first one
    forwardedIps = forwardedIpsStr.split ','
    ipAddress = forwardedIps[0]
  unless ipAddress
    ipAddress = req.connection.remoteAddress
  return ipAddress
