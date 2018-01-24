import Foundation

fileprivate let paramDictKey = "de.zeezide.µe.param"

/// A middleware which parses the URL query parameters.
/// You can then access the parameters using
///   `req.param("id")`.
public func querystring(req  : IncomingMessage,
                        res  : ServerResponse,
                        next : () -> ())
{
  // use Foundation to parse the `?a=x` parameters
  if let queryItems = URLComponents(string: req.header.target)?.queryItems {
    req.userInfo[paramDictKey] =
      Dictionary(grouping: queryItems, by: { $0.name })
        .mapValues { $0.flatMap({ $0.value })
	               .joined(separator: ",") }
  }
  
  next() // pass on control to next middleware
}

public extension IncomingMessage {
  
  /// Access query parameters, like:
  ///     
  ///     let userID = req.param("id")
  ///     let token  = req.param("token")
  ///
  func param(_ id: String) -> String? {
    return (userInfo[paramDictKey] as? [ String : String ])?[id]
  }
}
