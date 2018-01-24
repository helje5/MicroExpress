import HTTP

open class ServerResponse {

  /// Feel free to set an own response status here,
  /// defaults to 200 .ok.
  public var status  = HTTPResponseStatus.ok
  
  /// Response headers. Feel free to add more.
  public var headers = HTTPHeaders()
  
  /// Our connection to the client/browser.
  fileprivate var writer : HTTPResponseWriter
  
  /// Flag to track whether we wrote the response header
  private var didWriteHeader = false
  
  init(writer: HTTPResponseWriter) {
    self.writer = writer
  }
  
  /// An Express like `send()` function.
  open func send(_ s: String) throws {
    try flushHeader()   // make sure the response header is out
    writer.writeBody(s) // we ignore the result :->
    writer.done()       // tell the API we are done
  }

  /// Check whether we already wrote the response header. 
  /// If not, do so.  
  func flushHeader() throws {
    guard !didWriteHeader else { return } // done already
    didWriteHeader = true
    writer.writeHeader(status: status, headers: headers)
  }
}
