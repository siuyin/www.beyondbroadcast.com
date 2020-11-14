---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Getting Started With Embedded Systems Programming"
subtitle: ""
summary: "There is no subtitute for understanding the datasheet."
authors: [siuyin]
tags: [electronics, embedded systems, programming]
categories: [harware]
date: 2020-11-14T10:14:09+08:00
lastmod: 2020-11-14T10:14:09+08:00
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

## Simple chips are simple but complex chips are hard
I started programming Microchip PIC microcontrollers in PIC Assembly.
The basic chips were easy as there was a one-to-one correspondence
between the pins and function.

Then I used a chip with an ADC and things broke. I had to
consciously program if that pin was to be analog or digital.

Then came 32-bit microcontrollers. These were relatively
power hungry beasts that featured the ability to turn on
or turn off peripherals (eg the ADC) on the chip.
Now I had to consciously program turning on the peripheral.

## IDEs and Wizards are seductive but do not increase understanding
The purpose of Manufacturer provided IDEs, Wizards and Helpers
is to hide the details from you. You don't need to understand
the chip to use it. Just like you don't need to understand
how a car engine works for you to drive the car. Just use
our simple interface and you are driving!

This is the promise of ecosystems like the Arduino.
And they do very much deliver on the promise.
You can do a lot with Arduino! You can do even more
with the Manufacturer's IDEs, Wizards and Helpers.
Think of them like an advanced Arduino.

But the moment you step out of the well-marked path,
you are likely to get lost.

Why doesn't it work? All I did was to change this ...
and things broke.

Does this sound familiar? Read on if you want to learn
how I explored under the hood and learned to love
interpreting the datasheet.

## Understand the basics.
All microcontrollers comprise two major components:
1. Hardware
1. Software / Firmware

The hardware is fixed for a given part. Each part's hardware
composition is summarised on the first page of its datasheet.
Read this to determine if the part is suitable for your needs.

The Software and Firmware is where the bewilderment starts.
Understand your choices are these:
1. "High level" software like the Arduino, PlatformIO and MBed
  make certain assumptions
 for you and expose only what they think is absolutely necessary to you.
1. "Medium level" software like the Manufacturer's IDEs, Wizards
 and helpers make fewer assumptions. They usually expose a
 "Hardware Abstraction Layer" or "Logical drivers" to let you
 treat whole classes of devices in a uniform way. For example,
 the code to drive an ADC (analog to digital converter) is the same
 throughout a chip family.
1. "Low level" C or Assembly works by manipulating the
 chip's registers directly. These make no assumptions of what
 you want to do with the part. Getting started here is
 challenging as there are many subsystems that need to be
 properly configured for your application to work.


I recommend using software at the "High Level" -- Arduino
style to get started. It is important to make initial progress
and to get going. As I mentioned earlier, you can do a *lot*
with Arduino style software

High level software like the Arduino start to show its
limitations when you begin to use interrupts.

Interrupts allow you to perform multiple tasks concurrently. The 
software instructs the CPU to work on each task a portion
of the time. This gives the illusion that multiple tasks
are running at the same time. They are actually running
one after another, but the rapid switching make it appear that 
they run in parallel.

At this stage most people switch to using the "Medium level"
software. And if you're like me you hit a brick wall -- hard!

The Arduino and the Manufacturer's software are meant for
different markets. The Arduino for makers and hobbyists and
the Manufacturer's software for professional engineers.

1. The language is radically different.
1. The rich, openly contributed library ecosystem
 of Arduino libraries is often much reduced or not
 represented at all with the Manufacturer's software.

In short, the Arduino and "High level" software focus on
helping you assemble existing modules to get them
to work together.

The Manufacturer's "Medium level" software tries to
help the professional engineer create a new
embedded system application. Say a new washing machine,
or a better anti-lock braking system for a car.

## Why I chose to not "Just use the Arduino"

First, let me state this clearly. I *do* use
Arduino level software. There is nothing wrong with it.
I use it for "simple" applications.
If you understand its limitations, your application
will work well.

It sometimes makes sense to "throw hardware" at the problem.
This is the case when Arduino level software is too slow,
or you run out of Flash or RAM. Use a more powerful,
costlier part.

But if you don't *want* to use a costlier, more powerful part,
the you have to optimise. Optimise by using "Medium" or even
"Low" level software.

Here are some stats for you. Many of the products you use have
microcontrollers with less than 1K of Flash and 100 bytes of RAM.
Compare this with the "basic" ATMega328 used with the Arduino Uno
with 32K of Flash and 2K of RAM.

## Be prepared to learn if you want to optimise
1. Create a mental model of the part you want to use.
 Draw and organisation chart of sorts. The "CEO" is 
 obviously the CPU but it is the Clock system that
 is the part's Chief Operating Officer.
1. Draw the communications paths between the
 different peripherals. Often, but not always,
 the communicate over a common bus.
1. Understand how to reach each peripheral.
 Think of each peripheral as a "Department"
 within the organisation chart. These Departments
 have "In" and "Out" boxes which are the peripheral's
 registers. Each register has an address.
1. Learn to speak and listen to the peripheral.
 You communicate by setting and reading its registers.
1. Take is slow with the Interrupt Controller.
 This sub-system is very powerful, and with great
 power comes the responsibility of understanding how
 interrupts work. In short, you usually have to:
    1. save the state of the task being interrupted
    1. acknowledge the interrupt but resetting a flag
    1. perform your interrupt service routine. Keep it short!
    1. restore the state of the task that was interrupted

## Compiled or Interpreted?
C and Assembly are compiled languages. You run your code
through a compiler to generate a binary that is flashed on the part.

CicuitPython, MicroPython, Lua are interpreted. You first flash
the Python or Lua on to the part and then communicate with the
part via a serial terminal.

Forth is like Python and Lua except it is both interpreted and
compiled. You flash Forth on to the part and communicate over
a serial terminal. But the Forth programs you write are
compiled on the chip to machine code.

Python is the easiest language to learn. It is familiar but
requires powerful hardware to run it. An ATMega328 has no
chance of running Python.

Forth is the weirdest language to learn. But it will easily
run on limited hardware like an ATMega328. I actually use
STM8ef Forth running on an STM8S003F3/STM8S103F3 with 8K Flash
and 1K RAM.

I played with "Medium" level software for a while, but
I feel with Interpreted environments like Forth, it is easier
to migrate from "High" level software directly to "Low" level
software.

Forth and other interperted environments
let you directly set and read registers *interactively*.
If you want to turn on an LED, set a bit on the appropriate GPIO
register. It that doesn't work, try sending the Clock signal
to the GPIO port. Do that by instructing the Clock subsystem to
enable the GPIO port.

After you have learned the peripherals, you can translate your
code to C or even Assembly.

That is how you can optimise the use of your microcontrollers.

## To Summarise
1. It is OK to use "High Level" software like Arduino,
 PlatformIO or MBed. However do understand their limitations.
1. "Medium Level" software provided by Manufacturer's IDEs,
 Wizards and Helpers target professional engineers trying
 to build new products at a reasonable cost, quickly.
1. Interpreted environments like Python, Lua and Forth
 make it easy to learn peripherals on microcontrollers by
 interactively manipulating registers. Forth is particularly
 efficient and small.
1. Once you master register level programming, it is
 easy to port your Forth/Python/Lua code to low-level C or Assembly.
