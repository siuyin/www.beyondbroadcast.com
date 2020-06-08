---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Mediaflex DRA Interface"
summary: "2020. Data interface to receive updates from TMD's Mediaflex MAM for Discovery's DRA asset manager."
authors: []
tags: [software]
categories: []
date: 2020-03-08T15:23:41+08:00

# Optional external URL for project (replaces project detail page).
external_link: ""

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Custom links (optional).
#   Uncomment and edit lines below to show custom links.
# links:
# - name: Follow
#   url: https://twitter.com
#   icon_pack: fab
#   icon: twitter

url_code: ""
url_pdf: ""
url_slides: ""
url_video: ""

# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
slides: ""
---
mediaflex-dra-interface leverages Amazon SQS (Simple Queue Service) to retrieve updates for Discovery's DRA asset manager.

Update elements include:
1. QC status
1. Wav language, audio layout and stacked (broadcast-readiness) status.
