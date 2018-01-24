import Foundation
import HTTP

open class Express : Router {
  
  override public init() {}
  
  /// Start the HTTP server on the given port.
  /// Note: This function never returns.
  open func listen(_ port: Int) {
    let server = HTTPServer()
    do {
      // Ask the Swift Server API to create a HTTP server,
      // and pass over the request handler function.
      try server.start(port: 1337) {
        header, writer in
        
        // create our API wrappers
        let req = IncomingMessage(header: header)
        let res = ServerResponse (writer: writer)
        
        // trigger Router
        do {
          try self.handle(request: req, response: res)
        }
        catch {
          res.status = .internalServerError
          try? res.send("Swift Error: \(error)")
        }
        
        // We do not process `POST` input in MicroExpress 😎
        return .discardBody
      }
    }
    catch {
      fatalError("failed to start server: \(error)")
    }
    
    // never exits:
    RunLoop.current.run()
  }
}
