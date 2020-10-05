---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Interactive Development on Small Microcontrollers"
subtitle: "STM8S103F3: 8K flash 1K RAM"
summary: "How STM8ef Forth can be used in space-constrained MCUs."
authors: [siuyin]
tags: [tools]
categories: []
date: 2020-10-05T16:17:14+08:00
lastmod: 2020-10-05T16:17:14+08:00
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
## Python on MCUs

Microcontrollers are usually programmed with C or assembler.
The edit-compile-flash-debug cycle can get tedious. Hence the
introduction of interactive programming environments like MicroPython
and its derivative CircuitPython.

These MCU specific pythons allow you to have an interactive
programming environment within the MCU you are targeting.
The cost being the size of the python environment which makes
it suitable mainly for higher spec'ed MCUs typically a 32-bit part
with 256K of flash and at least 16K of RAM.

### Python Pros and cons

1. Python is a easy to learn language.
1. Its strict identation requirements results in well-formatted
 code. However using tabs in place of spaces creates issues.
1. Python on an MCU requires 256K flash and 16K RAM or more.

## Forth on MCUs
Python will not fit on the STM8S103F3 with 8K flash and 1K RAM.
But Forth will, specifically STM8ef. That Forth takes up about
5K of flash and leaves you with most of the RAM unused.

### Forth Pros and cons

1. Forth can be treated as an "interactive macro-assembler".
1. Its post-fix, Reverse Polish Notation programming style
 makes it very unconventional and different. Hence a greater
 learning curve.
1. It can fit on 8K Flash and 1K RAM.


### Getting Started with STM8ef

#### Hardware

1. STM8S103F3 or STM8S003F3 board.
 I built my own by soldering a STM8S103 TSSOP-20 chip
 to a breakout board. The STM8S003F3 is a slightly
 lower spec'ed device with the same 8K flash and 1K RAM
 but with lower EEPROM and flash durability.

1. A st-link V2 programmer. Clones are available from
 sources like AliExpress for about SGD 2.50 (USD 2).
 The st-link is only used to initially
 flash the STM8S103F3 with STM8ef.
 It is not required in the normal development process.

1. A USB to TTL UART. I used a CP2102 based module,
 but the cheaper CH340 based module should also work.
 This modules provides the 9600,8,N,1 serial link
 to the STM8S103F3 running STM8ef.

#### Software

1. stm8flash (https://github.com/vdudouyt/stm8flash).
 Used with st-link V2 to flash STM8ef to the STM8S103F3 board.

1. STM8ef binary from https://github.com/TG9541/stm8ef/releases .
 Download the stem8ef-bin tgz or zip file, extract and locate
 the binary in out/MINDEV/MINDEV.ihx .
 MINDEV is short of minimal development board with is the
 STM8S103F3 or STM8S004P3 board. This ihx file is the binary
 in Intel hex format.

1. e4thcom from https://wiki.forth-ev.de/doku.php/en:projects:e4thcom 
 This software is a terminal emulator like PuTTY (Windows) or minicom (Linux).
 e4thcom has additional capabilities to upload files, making it
 better suited to Forth development.

#### Step-by-step instructions

1. Build your hardware. Not necessary if you purchased a pre-assembled
  STM8S103F3 Minimum Development Board (eg from https://www.aliexpress.com/item/32859602851.html).

1. Connect your TTL UART to PD5 (TX, pin 2) and PD6 (RX, pin 3) on the STM8S103F3.

1. I wired an LED with a current limited resistor to ground from PA2, pin 6.
 The pre-assembled board will likely have an LED wired from PD3, pin 20.

1. Flash your board with STM8ef thus:
    ```
    stm8flash -p stm8s103f3 -c stlinkv2 -w MINDEV.ihx
    ```
    -p defines the part, -c the programmer, -w writes the file to the part.

1. Connect to the board with e4thcom thus:
    ```
    e4thcom -t stm8ef -d ttyUSB0
    ```
    -t is the target forth, -d is the device name of the USB to TTL UART,
    mine is at /dev/ttyUSB0 but other modules can also show on with
    device names like /dev/ttyACM0 .

1. Go through the tutorial at https://github.com/TG9541/stm8ef/wiki/STM8-eForth-Programming.
 Further resources at the main STM8ef github page at https://github.com/TG9541/stm8ef .
