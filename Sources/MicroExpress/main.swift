let app = Express()

app.use(querystring) // parse query params

app.use { req, res, next in // Logging
  print("\(req.header.method): \(req.header.target)")
  next() // continue processing
}

app.get("/todomvc") { _, res, _ in
  try res.json(todos) // send JSON to the browser
}

app.get { req, res, _ in
  let text = req.param("text") ?? "Schwifty"
  try res.send("Hello, \(text) world! ")
}

app.listen(1337)
