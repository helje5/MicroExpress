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
        print("req:", header)
        let head = HTTPResponseHead(version: header.version,
                                    status: .ok)
        let part = HTTPServerResponsePart.head(head)
        _ = ctx.channel.write(part)
        
        var buffer = ctx.channel.allocator.buffer(capacity: 42)
        buffer.write(string: "Hello Schwifty World!")
        let bodypart = HTTPServerResponsePart.body(.byteBuffer(buffer))
        _ = ctx.channel.write(bodypart)
        
        let endpart = HTTPServerResponsePart.end(nil)
        _ = ctx.channel.writeAndFlush(endpart).then {
          ctx.channel.close()
        }

      // ignore incoming content to keep it micro :-)
      case .body, .end: break
      }
    }
  }
}

