// File: Express.swift - create this in Sources/MicroExpress

import Foundation
import NIO
import NIOHTTP1

open class Express {
  
  let loopGroup =
    MultiThreadedEventLoopGroup(numThreads: System.coreCount)
  
  open func listen(_ port: Int) {
    let reuseAddrOpt = ChannelOptions.socket(
      SocketOptionLevel(SOL_SOCKET),
      SO_REUSEADDR)
    let bootstrap = ServerBootstrap(group: loopGroup)
      .serverChannelOption(ChannelOptions.backlog, value: 256)
      .serverChannelOption(reuseAddrOpt, value: 1)
      
      .childChannelInitializer { channel in
        channel.pipeline.addHTTPServerHandlers().then {
          channel.pipeline.add(handler: HTTPHandler())
        }
      }
      
      .childChannelOption(ChannelOptions.socket(
        IPPROTO_TCP, TCP_NODELAY), value: 1)
      .childChannelOption(reuseAddrOpt, value: 1)
      .childChannelOption(ChannelOptions.maxMessagesPerRead,
                          value: 1)
    
    do {
      let serverChannel =
        try bootstrap.bind(host: "localhost", port: port)
          .wait()
      print("Server running on:", serverChannel.localAddress!)
      
      try serverChannel.closeFuture.wait() // runs forever
    }
    catch {
      fatalError("failed to start server: \(error)")
    }
  }

  final class HTTPHandler : ChannelInboundHandler {
    typealias InboundIn = HTTPServerRequestPart
    
    func channelRead(ctx: ChannelHandlerContext, data: NIOAny) {
      let reqPart = self.unwrapInboundIn(data)
      
      switch reqPart {
      case .head(let header):
        let request  = IncomingMessage(header: header)
        let response = ServerResponse(channel: ctx.channel)
        
        print("req:", header.method, header.uri)
        response.send("Way easier to send data!!!")

      // ignore incoming content to keep it micro :-)
      case .body, .end: break
      }
    }
  }
}

