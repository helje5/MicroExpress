public typealias Middleware =
         ( IncomingMessage, ServerResponse, () -> () )
         throws -> Void
