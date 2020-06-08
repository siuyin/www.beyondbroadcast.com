---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Impressions of NAB 2019"
subtitle: ""
summary: "NAB 2019 saw the maturing and growing pains of high-bandwidth IP video (2110 and 2022-6)"
authors: []
tags: [NAB,SMPTE 2110,SMPTE 2022-6,cloud]
categories: []
date: 2019-04-24
lastmod: 2019-04-24
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
NAB 2019 saw the maturing and growing pains of high-bandwidth IP video (2110 and 2022-6). At the same time streaming IP video has matured and is being optimised.
Drones seem to have lost the limelight but moving broadcast operations to the cloud is as fashionable as ever.

IP: 2110 and 2022-6

The hype is over and now comes the messy implementation. I feel both IP and 12G SDI camps were rather subdued this year. I learned from listening to Telos' Livewire talk that PTP can be quite a challenge to get right with incorrect timing leading to clicks, pops and mutes in the audio stream.

Indeed 2110 and 2022-6 on IP when done wrong can bring down the network! I learned about narrow gapped senders (i.e synchronous video) and about wide continuous senders (typical IT-style traffic).

Wide and narrow referring to timing spreads. Now if video sources are synchronous, as they usually are, they will all start to send at the same time, and with high intensity / bandwidth. Network switches must have deep enough buffers to absorb this traffic or data is lost and video is broken.

IP: AMWA NMOS and ember+

The next implementation challenge is control and management of IP sources / streams / flows. At NAB 2019 I'm beginning to see a divide between NMOS (Networked Media Open Specifications) by AMWA (Advanced Media Workflow Association) and ember+ from Lawo.

This reminds me of AES67 and Dante for IP audio. Audinate's Dante has its own IP audio transport but has now chosen to embrace Open Standards AES67 transport. However it still retains the Dante configuration and control protocol for managing IP audio sources.

In the end open standards will prevail but meanwhile "working solutions" will be sold and installed. AIMS prevailed and ASPEN faded away.

IP: Streaming, SRT, SSIM and VMAF

Remember when you had to microwave remote / OB sources back to base. This has largely been supplanted by compressed video streams delivered over IP.

The buzz on the floor this year was SRT (Secure Reliable Transport -- see srtalliance.org) This is an open source transport protocol that aims to achieve the best quality video with the lowest latency for delivery over an unreliable, possibly congested internet.

SRT addresses contribution IP delivery. There is also distribution IP streaming where bandwidth efficiency is paramount as it affects CDN (content delivery network) costs. Here automated video quality assessment tools like SSIM (Strutural Similarity) and its derivatives and VMAF (Video Multi-method Assesment Fusion) come into play. The bottom line is you want an automated way to encode with as little bandwidth as possible but still have the video look good.

Cloud Operations

Moving to the cloud has been fashionable for sometime now. I've heard that packaging existing software into Docker containers and running them on kubernetes clusters is much like old wine in a new bottle. I agree but that new bottle makes the wine so much easier to drink.

It is easier to consume because the CapEx (Capital Expenditure) model is now replaced with an OpEx (Operating Expenditure). This improves business agility because the project can simply be killed without having to write off large capital spending. This certainly encourages experimentation.

I feel cloud adoption should be an all-in effort. My opinion is a hybrid strategy maintaining a physical broadcast facility and having some components in the cloud results in operational complexity and higher costs.

Operational complexity in building interfaces / bridges between legacy system and new system running in the cloud.

Higher cost because large video assets contribute to bandwidth transfer cost when moved back and forth from the cloud.

Cheers!
