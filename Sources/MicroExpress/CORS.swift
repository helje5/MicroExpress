public func cors(allowOrigin origin: String) -> Middleware {
  return { req, res, next in
    res.headers["Access-Control-Allow-Origin"]  = origin
    res.headers["Access-Control-Allow-Headers"] = "Accept, Content-Type"
    res.headers["Access-Control-Allow-Methods"] = "GET, OPTIONS"
    
    if req.header.method == .options { // we handle the options
      res.headers["Allow"] = "GET, OPTIONS"
      try res.send("")
    }
    else { // we set the headers
      next()
    }
  }
}
