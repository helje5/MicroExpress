// File: Middleware.swift - create this in Sources/MicroExpress

public typealias Next = ( Any... ) -> Void

public typealias Middleware =
  ( IncomingMessage,
    ServerResponse,
    @escaping Next ) -> Void

