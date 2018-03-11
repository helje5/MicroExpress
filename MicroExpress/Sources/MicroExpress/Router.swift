// File: Router.swift - create this in Sources/MicroExpress

open class Router {
  
  /// The sequence of Middleware functions.
  private var middleware = [ Middleware ]()
  
  /// Add another middleware (or many) to the list
  open func use(_ middleware: Middleware...) {
    self.middleware.append(contentsOf: middleware)
  }
  
  /// Request handler. Calls its middleware list
  /// in sequence until one doesn't call `next()`.
  func handle(request        : IncomingMessage,
              response       : ServerResponse,
              next upperNext : @escaping Next)
  {
    let stack = self.middleware
    guard !stack.isEmpty else { return upperNext() }
    
    var next : Next? = { ( args : Any... ) in }
    var i = stack.startIndex
    next = { (args : Any...) in
      // grab next item from matching middleware array
      let middleware = stack[i]
      i = stack.index(after: i)
      
      let isLast = i == stack.endIndex
      middleware(request, response, isLast ? upperNext : next!)
    }
    
    next!()
  }
}

public extension Router {
  
  /// Register a middleware which triggers on a `GET`
  /// with a specific path prefix.
  public func get(_ path: String = "",
                  middleware: @escaping Middleware)
  {
    use { req, res, next in
      guard req.header.method == .GET,
        req.header.uri.hasPrefix(path)
       else { return next() }
      
      middleware(req, res, next)
    }
  }
}
