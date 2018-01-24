open class Router {

  /// The sequence of Middleware functions.
  private var middleware = [ Middleware ]()
  
  /// Add another middleware (or many) to the list
  open func use(_ middleware: Middleware...) {
    self.middleware.append(contentsOf: middleware)
  }
  
  /// Request handler. Calls its middleware list
  /// in sequence until one doesn't call `next()`.
  func handle(request  : IncomingMessage,
              response : ServerResponse,
              next     : () -> () = {}) throws
  {
    var didCallNext = true // to handle the empty case
    
    // loop over each middleware, call it until one
    // doesn't call `next`
    for middleware in middleware {
      didCallNext = false
      
      try middleware(request, response) {
        didCallNext = true
      }
      
      // did the middleware call `next()`?
      // if not, stop, request is handled
      guard didCallNext else { break }
    }
    
    if !didCallNext { return } // done

    // All of the middleware called next(),
    // none handled the request.
    response.status = .internalServerError
    try response.send("No middleware handled the request!")
  }
}

public extension Router {
  
  /// Register a middleware which triggers on a `GET`
  /// with a specific path prefix.
  func get(_ path: String = "",  middleware: @escaping Middleware) {
    use { req, res, next in
      guard req.header.method == .get,
            req.header.target.hasPrefix(path)
       else { return next() }
      
      try middleware(req, res, next)
    }
  }
}
