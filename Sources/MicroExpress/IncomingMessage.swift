// File: IncomingMessage.swift - create this in Sources/MicroExpress

import NIOHTTP1

open class IncomingMessage {
  
  public let header   : HTTPRequestHead
  public var userInfo = [ String : Any ]()
  
  init(header: HTTPRequestHead) {
    self.header = header
  }
}

