let app = Express()

app.use(querystring) // parse query params

app.use { req, res, next in // Logging
  print("\(req.header.method): \(req.header.target)")
  next() // continue processing
}

app.get { req, res, _ in // Request Handling
  let text = req.param("text") ?? "Schwifty"
  try res.send("Hello, \(text) world! ")
}

app.listen(1337)
