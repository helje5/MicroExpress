// File: main.swift - Add to existing file
let app = Express()

// Reusable middleware up here
app.use(querystring) // parse query params

// Logging
app.use { req, res, next in
  print("\(req.header.method):", req.header.uri)
  next() // continue processing
}

app.get("/todomvc") { _, res, _ in
  // send JSON to the browser
  res.json(todos)
}

app.get("/moo") { req, res, next in
  res.send("Muhhh")
}

app.get { req, res, _ in
  // `param` is provided by querystring
  let text = req.param("text")
          ?? "Schwifty"
  res.send("Hello, \(text) world!")
}

// start server
app.listen(1337)
