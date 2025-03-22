---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Software Tools I Have Used and Evaluated"
subtitle: ""
summary: "This is a list of tools I have found useful in various usage contexts."
authors: [Loh Siu Yin]
tags: [Tools, Software Engineering]
categories: []
date: 2025-03-22T13:32:49+08:00
lastmod: 2025-03-22T13:32:49+08:00
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---
## Programming Languages
1. `go`: [go](https://go.dev/) is easy to use, simple, targets many OSes and Architectures (GOOS=windows, GOARCH=amd64). Use: `go tool dist list` to see the complete list. eg. [http doc](https://pkg.go.dev/net/http). Books: [Effective Go](https://go.dev/doc/effective_go), [Language Spec](https://go.dev/ref/spec).

   * go embedded html fileserver: [gist](https://gist.github.com/siuyin/8c666a15b15d9be4cb70fa4ab32ef16e#file-main-go).

1. `javascript`: [javascript](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference) is built into browsers. For the backend, I use [deno](https://deno.com/) as it can natively handle [typescript](https://www.typescriptlang.org/) code.

   * `htmx`: [htmx](https://htmx.org/) enables interactivity with custom html attribute. [code example](https://gist.github.com/siuyin/8c666a15b15d9be4cb70fa4ab32ef16e#file-index-html).

1. `rust`: [rust](https://www.rust-lang.org/) is low-level, memory-safe, fast language. Can target small microcontrollers like the [CH32V003](https://docs.rs/ch32v0/latest/ch32v0/index.html). Also good for creating fast, memory safe tooling (eg vite's [Oxc](https://oxc.rs/) uses rust. tooling). Books: [rust book](https://doc.rust-lang.org/book/), [Effective Rust](https://effective-rust.com/)

    * leap year [example](https://gist.github.com/siuyin/2c371f203b750577b0c1871427168016).

## Databases
1. `nats kv`: [nats](https://pkg.go.dev/github.com/nats-io/nats.go) can be [embedded](https://youtu.be/cdTrl8UfcBo?si=BpT-JhwGyr_lzgF0) into your gobinary to provide a key-value store, object store in addition to providing event streams: [jetstream](https://docs.nats.io/nats-concepts/jetstream).

1. `chromem-go`: [chromem-go](https://github.com/philippgille/chromem-go) is a pure-go embeddable vector database. See code [examples](https://github.com/siuyin/useful-tools-talk/blob/main/cmd/rag/main.go).

1. `bolt`: [bolt](https://github.com/boltdb/bolt) is a pure Go key/value store library that has key prefix and range scanning. Think [sqlite]() but without SQL and able to target any of `go`s targets

1. `buntDB`: [buntDB](https://github.com/tidwall/buntdb) is a low-level, in-memory, key/value store in pure Go. It persists to disk, is ACID compliant, and uses locking for multiple readers and a single writer. It supports custom indexes and geospatial data. It's ideal for projects that need a dependable database and favor speed over data size.

## Message brokers
1. `nats`: [nats](https://nats.io/) is small, fast and features [location independence](https://docs.nats.io/nats-concepts/overview).

1. `mqtt`: nats can work as an [mqtt broker](https://github.com/nats-io/nats-server/blob/main/server/README-MQTT.md). nats mqtt [bridges](https://docs.nats.io/running-a-nats-service/configuration/mqtt#communication-between-mqtt-and-nats) mqtt and nats jetstream.

## Load testing
1. `hey`: [hey](https://github.com/rakyll/hey): `hey -n 10 -c 2 http://localhost:8080/`.
1. `apache bench`: [ab](https://httpd.apache.org/docs/2.4/programs/ab.html): `ab -n 10 -c 2 http://localhost:8080/`.