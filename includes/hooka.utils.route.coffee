this.route = (req, res) ->
  
  # Build the Context object, modules can act directly on the context response if they need to
  context = 
    response: res
    request: req
    url: req.url
  
  # Fire hook init
  if hooka.hooks.init?
    for hook in hooka.hooks.init
      do (hook) ->
        hook(context)
  
  # Grab all routers and see if any of them want to deal with this context
  if hooka.hooks.routers?
    for router in hooka.hooks.routers
      do (router) ->
        output = router(context)
        if output
          res.writeHead 200, {"Content-Type": "text/html"}
          res.end output
          return TRUE
  
  # It looks as though no router wants to deal with this request
  res.writeHead 404
  res.end 'Sorry, we cound not find the page you are looking for'
  return FALSE