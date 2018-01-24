let app = Express()

app.use { req, res, next in // Logging
  print("\(req.header.method): \(req.header.target)")
  next() // continue processing
}

app.use { _, res, _ in      // Request Handling
  try res.send("Hello, Schwifty world!")
}

app.listen(1337)
