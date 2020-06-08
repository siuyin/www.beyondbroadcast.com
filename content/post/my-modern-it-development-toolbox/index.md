---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "My Modern IT Development Toolbox"
subtitle: ""
summary: "How would you productively write, deploy and maintain modern IT applications? Here is how I do it."
authors: [siuyin]
tags: [development,tools,languages]
categories: []
date: 2019-02-20
lastmod: 2019-02-20
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
How would you productively write, deploy and maintain modern IT applications? Here is how I do it.

My development language is Go (golang). It is small, concise, readable and maintainable. It has concurrency features built-in and code written with it is easy to extend through its unique interface system.

Docker alone is insufficient in a production environment. What if the application fails? How does it get restarted?

Docker can automatically restart failed containers but it falls short in a complex microservices situation where many services must interact to deliver the application.

Enter kubernetes. Kubernetes allows sophisticated management / orchestration of multiple container-based services.

Kubernetes is powerful but complex and has a long learning curve.

Helm eases the packaging of applications for deployment to kubernetes clusters. Kubernetes manifiests are templated allowing for flexible deployment of the packaged applications in multiple environments (eg. Staging, Production etc.)

Skaffold helps with automating the steps in developing an application for kubernetes, Compiling, packaging to a docker container (with a standard dockerfile), deploying it to a cluster (with kubectl or helm) and cleaning up when the application is to be removed.

My supporting cast of tools are:
* vim and vim-go: a minimal, productive and complete source code editor.
* git: a powerful, distributed source code repository
* ssh: a secure terminal program to log in to servers
* mosh: a secure terminal program that minimizes the effects of high-latency connections but still uses ssh authentication.
