<h2>µExpress
  <img src="http://zeezide.com/img/MicroExpressIcon1024.png"
       align="right" width="100" height="100" />
</h2>

![Swift 4](https://img.shields.io/badge/swift-4-blue.svg)
![macOS](https://img.shields.io/badge/os-macOS-green.svg?style=flat)
![tuxOS](https://img.shields.io/badge/os-tuxOS-green.svg?style=flat)
![Travis](https://travis-ci.org/MicroExpress/MicroExpress.svg?branch=master)

> **NOTE**:
> The repository containing the 
> [asynchronous variant of MicroExpress](https://github.com/NozeIO/MicroExpress)
> now lives at [Noze.io](https://github.com/NozeIO).
> Images have been updated.
> This repository will eventually revert to the
> [synchronous HTTP API variant](https://github.com/AlwaysRightInstitute/MicroExpress/tree/branches/swift-server-http-api).

A micro server framework on top of
[Swift NIO](https://github.com/apple/swift-nio).

It adds an Express like API on top of the 
low level [Swift NIO](https://github.com/apple/swift-nio/tree/1.1.0) API.
```swift
import MicroExpress

let app = Express()

app.get("/moo") { req, res, next in
  res.send("Muhhh")
}
app.get("/json") { _, res, _ in
  res.json([ "a": 42, "b": 1337 ])
}
app.get("/") { _, res, _ in
  res.send("Homepage")
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
  - Part 3 [µExpress/NIO](http://www.alwaysrightinstitute.com/microexpress-nio)

Please checkout [Part 3](http://www.alwaysrightinstitute.com/microexpress-nio)
of our blog series to learn what this is about.
This is a tiny framework, for a more full featured, *synchronous*
Express-like API in Swift, have a look at 
[ExExpress](https://github.com/modswift/ExExpress)
(as used in [ApacheExpress](http://apacheexpress.io)).
[Noze.io](http://noze.io) comes w/ an *asynchronous* variant (but is using
Dispatch, not Swift NIO - stay tuned).


## Using the Package

Micro Hello World in 5 minutes (or in 30s using the 
[swift-xcode image](#swift-xcode) below):

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
             .branch("branches/swift-nio-lib"))
  ],
  targets: [
    .target(name: "MicroHelloWorld",
            dependencies: [ "MicroExpress" ])
  ]
)
```

Change the `main.swift` from `print("Hello World")` into:
```swift
import MicroExpress

let app = Express()

app.get("/") { req, res, next in
  res.send("Hello World")
}

app.listen(1337)
```

```shell
$ swift build
$ swift run
```

Done. Access via: [http://localhost:1337/](http://localhost:1337/)


## Building the Package

### Xcode

Choose the easy way using the 
[swift-xcode](https://swiftxcode.github.io)
[Swift NIO image](https://github.com/SwiftXcode/SwiftNIO_XcodeImage),
or take the hard way and use `swift package generate-xcodeproj`.

#### swift-xcode

```shell
brew install swiftxcode/swiftxcode/swift-xcode-nio
swift xcode link-templates # <-- important!
```

1. Create new project (Command-Shift-N or File/New/Project ...)
2. choose macOS / Server / Swift NIO template
3. check desired options
4. build and run, and then have fun!

<img src="http://zeezide.com/img/microexpress-nio/01-new-project.jpg" align="center" />

<img src="http://zeezide.com/img/microexpress-nio/02-new-project.jpg" align="center" />

#### swift package generate-xcodeproj

Important: This creates a few schemes in the Xcode project. Make sure to
           select the right one when building & running.

```shell
$ swift package generate-xcodeproj
Fetching ...
Cloning ...
Resolving ...
generated: ./MicroExpress.xcodeproj

$ open MicroExpress.xcodeproj
```

### macOS /Linux Command Line

```shell
$ swift build
Fetching ...
Cloning ...
Resolving ...
Compile ...
Compile Swift Module ...
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
Compile ...
Compile Swift Module ...
Compile Swift Module 'MicroExpress' (9 sources)
Linking ./.build/x86_64-unknown-linux/debug/MicroExpress
Fetching ...
Cloning ...
Resolving ...

$ file .docker.build/x86_64-unknown-linux/debug/MicroExpress
.docker.build/x86_64-unknown-linux/debug/MicroExpress: 
  ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked ...
```


### Links

- [Swift NIO](https://github.com/apple/swift-nio)
- [Noze.io](http://noze.io)
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


### Want a Video Tutorial?

<img src="http://zeezide.com/img/swift-nio-cows.gif" />
