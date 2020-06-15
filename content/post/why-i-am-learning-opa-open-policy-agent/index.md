---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Why am I Learning OPA: the Open Policy Agent?"
subtitle: "" 
summary: "Steep learning curve but I feel it is worthwhile."
authors: [siuyin]
tags: [tools]
categories: []
date: 2020-06-15T15:28:10+08:00
lastmod: 2020-06-15T15:28:10+08:00
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
As at June 2020, the Open Policy Agent project is an incubator level project at the Cloud Native Computing Foundation.

Open Policy Agent answers questions about policies defined by you. As mentioned in the official documentation,
policies contain authorizations. ie. authorizations are a subset of policies.

An example policy could be "All websites must be https and not http" and an example authorization could be
"Only admins are allowed to execute this API". 

Thus Open Policy Agent is like a database which stores your policies and allows queries on the database.
The challenge I face is: those queries are not written in SQL. The data is also not loaded as SQL
insert statements. Instead they are expressed in this new language called `rego` (pronounced ray-go, say the
documentation).

The Open Policy Agent blog gives good reasons why they chose `rego`. I agree with them that rego is
well suited for expressing real-world policies, but the learning curve is steep. Mostly because I have
to _unlearn_ what I expect from traditional programming languages.

So why bother to learn rego and Open Policy Agent? Here are my reasons:
1. rego expresses policies _very_ well and Open Policy Agent can answer questions like:
  "Which servers in my infrastructure are not compliant with policy and why?".
  It can also answer more mundane questions like "Should the user "Alice" authenticated
  with a "user" role be allowed to access this resource?".
1. Open Policy Agent runs as a separate process (just like a regular database) and
  answers questions through a REST API. Policies (data) can be loaded on the fly
  without restarting the Agent. If you write in the `go` language, you can also
  link-in Open Policy Agent as a library. This makes for a very compact,
  static binary deliverable with no external dependencies.
1. It is a _very_ fast in-memory database to answer your application's policy questions.
  However if your data / policies cannot fit into memory, the Open Policy Agent can also
  make http calls into your external data.
1. Open Policy Agent plays well with kubernetes, Envoy, Terraform, Kafka and even SQL. See https://www.openpolicyagent.org/
  for more info.

