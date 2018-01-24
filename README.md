<h2>µExpress
  <img src="http://zeezide.com/img/MicroExpressIcon1024.png"
       align="right" width="100" height="100" />
</h2>

![Swift 4](https://img.shields.io/badge/swift-4-blue.svg)
![macOS](https://img.shields.io/badge/os-macOS-green.svg?style=flat)
![tuxOS](https://img.shields.io/badge/os-tuxOS-green.svg?style=flat)
![Apache 2](https://img.shields.io/badge/apache-2-yellow.svg)
![Travis](https://travis-ci.org/MicroExpress/MicroExpress.svg?branch=master)

A micro server framework on top of the Swift Server API.

It adds an Express like API on top of the 
[raw Swift Server API](https://github.com/swift-server/http/tree/0.1.0):
```swift
import MicroExpress

let app = Express()

app.get("/moo") { req, res, next in
  try res.send("Muhhh")
}
app.get("/json") { _, res, _ in
  try res.json([ "a": 42, "b": 1337 ])
}
app.get("/") { _, res, _ in
  try res.send("Homepage")
}

app.listen(1337)
```


This package is part of the 
[Always Right Institute](http://www.alwaysrightinstitute.com)'s
blog series about the 
[Swift Server Workgroup](https://swift.org/server-apis/)'s
offical Swift
[HTTP API](https://github.com/swift-server/http).

- Blog series:
  - Part 1 [Using the Swift Server API 0.1.0](http://www.alwaysrightinstitute.com/http-010/)
  - Part 2 [µExpress](http://www.alwaysrightinstitute.com/microexpress/)

Please checkout [Part 2](http://www.alwaysrightinstitute.com/microexpress)
of our blog series to learn what this is about.
This is a tiny framework, for a more full featured, *synchronous*
Express-like API in Swift, have a look at 
[ExExpress](https://github.com/modswift/ExExpress)
(as used in [ApacheExpress](http://apacheexpress.io)).
[Noze.io](http://noze.io) comes w/ an *asynchronous* variant.


## Using the Package

Micro Hello World in 5 minutes:

```shell
$ mkdir MicroHelloWorld && cd MicroHelloWorld
$ swift package init --type executable
```

Update `Package.swift` to include the dependency:
```swift
// swift-tools-version:4.0
import PackageDescription

let package = Package(
  name: "MicroHelloWorld",
  dependencies: [
    .package(url: "https://github.com/AlwaysRightInstitute/MicroExpress.git", 
             branch: "master")
  ],
  targets: [
    .target(name: "MicroHelloWorld",
            dependencies: [ "MicroExpress" ])
  ]
)
```

Change the `main.swift` from `print("Hello World")` into:
```
import MicroExpress

let app = Express()

app.get("/") { req, res, next in
  try res.send("Hello World")
}

app.listen(1337)
```

```shell
$ swift build
$ swift run
Started server on port 1337 with 4 serial queues of each type and 8 accept sockets
```

Done. Access via: [http://localhost:1337/](http://localhost:1337/)


## Building the Package

### Xcode

Important: This creates a few schemes in the Xcode project. Make sure to
           select the right one when building & running.

```shell
$ swift package generate-xcodeproj
Fetching https://github.com/swift-server/http
Cloning https://github.com/swift-server/http
Resolving https://github.com/swift-server/http at 0.1.0
generated: ./MicroExpress.xcodeproj

$ open MicroExpress.xcodeproj
```

### macOS /Linux Command Line

```shell
$ swift build
Fetching https://github.com/swift-server/http
Cloning https://github.com/swift-server/http
Resolving https://github.com/swift-server/http at 0.1.0
Compile CHTTPParser http_parser.c
Compile Swift Module 'HTTP' (11 sources)
Compile Swift Module 'MicroExpress' (9 sources)
Linking ./.build/x86_64-apple-macosx10.10/debug/MicroExpress
```

### Linux via macOS Docker

```shell
$ docker run --rm \
  -v "${PWD}:/src" \
  -v "${PWD}/.docker.build:/src/.build" \
  swift:4.0.3 \
  bash -c 'cd /src && swift build'
Unable to find image 'swift:4.0.3' locally
4.0.3: Pulling from library/swift
8f7c85c2269a: Pull complete 
...
9783e1c76d2b: Pull complete 
Digest: sha256:6978675b95f749b54eab57163c663d45b25c431c6d50cb5b2983062a55cea3c6
Status: Downloaded newer image for swift:4.0.3
Compile CHTTPParser http_parser.c
Compile Swift Module 'HTTP' (11 sources)
Compile Swift Module 'MicroExpress' (9 sources)
Linking ./.build/x86_64-unknown-linux/debug/MicroExpress
Fetching https://github.com/swift-server/http
Cloning https://github.com/swift-server/http
Resolving https://github.com/swift-server/http at 0.1.0

$ file .docker.build/x86_64-unknown-linux/debug/MicroExpress
.docker.build/x86_64-unknown-linux/debug/MicroExpress: 
  ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked ...
```


### Links

- [ExExpress](https://github.com/modswift/ExExpress)
- JavaScript Originals
  - [Connect](https://github.com/senchalabs/connect)
  - [Express.js](http://expressjs.com/en/starter/hello-world.html)
- Swift Apache
  - [mod_swift](http://mod-swift.org)
  - [ApacheExpress](http://apacheexpress.io)
- [Swiftmon/S](https://github.com/NozeIO/swiftmons)

### Who

**MicroExpress** is brought to you by
the
[Always Right Institute](http://www.alwaysrightinstitute.com)
and
[ZeeZide](http://zeezide.de).
We like 
[feedback](https://twitter.com/ar_institute), 
GitHub stars, 
cool [contract work](http://zeezide.com/en/services/services.html),
presumably any form of praise you can think of.

<table width="100%" border="0">
    <tr>
      <td align="center" width="20%">
        <a href="http://apacheexpress.io"
          ><img src="http://zeezide.com/img/ApexIcon128.png" width="64" height="64" /></a>
      	<br />
      	ApacheExpress
      </td>
      <td align="center" width="20%">
        <a href="http://mod-swift.org"
          ><img src="http://zeezide.com/img/mod_swift-128x128.png" width="64" height="64" /></a>
      	<br />
      	mod_swift
      </td>
      <td align="center" width="20%">
        <a href="http://zeeql.io"
          ><img src="http://zeezide.com/img/ZeeQLIconQL128.png" width="64" height="64" /></a>
        <br />
        ZeeQL
      </td>
      <td align="center" width="20%">
        <a href="http://noze.io"
          ><img src="https://pbs.twimg.com/profile_images/725354235056017409/poiNAOlB_400x400.jpg" width="64" height="64" /></a>
        <br />
        Noze.io
      </td>
      <td align="center" width="20%">
        <a href="https://github.com/ZeeZide/UXKit"
          ><img src="http://zeezide.com/img/UXKitIcon1024.png" width="64" height="64" /></a>
        <br />
        UXKit
      </td>
    </tr>
</table>