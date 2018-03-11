// File: main.swift - Add to existing file
let app = Express()

// Logging
app.use { req, res, next in
  print("\(req.header.method):", req.header.uri)
  next() // continue processing
}

app.get("/hello") { _, res, _ in
  res.send("Hello")
}

app.get("/moo") { req, res, next in
  res.send("Muhhh")
}

// Request Handling
app.use { _, res, _ in
  res.send("Hello, Schwifty world!")
}

app.listen(1337)
