import HTTP

public class IncomingMessage {

  public let header   : HTTPRequest // Swift Server API
  public var userInfo = [ String : Any ]()

  init(header: HTTPRequest) {
    self.header = header
  }
}
