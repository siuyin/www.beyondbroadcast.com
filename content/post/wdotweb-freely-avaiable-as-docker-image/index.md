---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "wdotweb Freely Avaiable as a Docker Image"
subtitle: ""
summary: "wdot is my workflow diagramming tool."
authors: []
tags: [workflow,tools]
categories: []
date: 2015-06-18
lastmod: 2015-06-18
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

wdot is my workflow diagramming tool. See http://wdot.rubyforge.org/rdoc/ .

It is now freely available from the docker hub:

```
sudo docker pull siuyin/wdotweb:20140820
sudo docker run -d --name wdotweb -p 8188:8188 siuyin/wdotweb:20140820
```
You will now have wdotweb running on port 8188:
```
http://localhost:8188/
```
