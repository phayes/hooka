this.route = (req, res) ->
  
  # Build the Context object, modules can act directly on the context response if they need to
  context = 
    response: res
    request: req
    url: req.url
  
  # Fire hook init
  if hooka.hook.init?
    for hook in hooka.hook.init
      do (hook) ->
        hook(context)
  
  # Grab all routers and see if any of them want to deal with this context
  if hooka.hook.routers?
    for router in hooka.hook.routers
      do (router) ->
        output = router(context)
        if output
          res.writeHead 200, {"Content-Type": "text/html"}
          res.end output
          return true
  
  # It looks as though no router wants to deal with this request
  res.writeHead 404
  res.end 'Sorry, we cound not find the page you are looking for'
  return false