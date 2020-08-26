---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Embedded Development With Low Cost Microcontrollers"
subtitle: ""
summary: "A bare-metal introduction to using ARM Cortex-M microcontrollers."
authors: []
tags: [embedded]
categories: []
date: 2020-07-17T17:00:06+08:00
lastmod: 2020-07-17T17:00:06+08:00
featured: false
draft: true

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
Cortex-M micros are very powerful and low-cost.
They are easy to use with the manufacturer's tools and libraries.
These tools however hide the bare-metal
under many layers of software abstraction.


Small 8-bit PIC micros from Microchip and 
16-bit MSP420G2 (Value Line) series from TI are also relatively easy to program.
These chips are very close to the hardware.
Development only needed a 
header file, device datasheets and 
programming reference manuals.

Not so for the ARM Cortex-M micros. This post documents my learning of
how to use gcc to program these capable micros "close to the metal".
I will specifically be programming NXP  MKL05Z4 devices
via the FRDM-KL05Z development board.

## Tools overview
1. You need a compiler/linker to compile and link your code to ARM binaries. I use gnu-rm
 to cross-compile from a linux host on X86-64 to arm.
1. You also need a means to program (flash) the micro. This could be built in
 on the development board, or it may be an external USB dongle.
 The FRDM-KL05Z has a programmer on board but the STM32F103C8T6 "blue pill"
 requires an external ST-LINK/V2 USB dongle. 
1. Optional, but very desirable, is a way to debug your code on the micro as it runs.
 If you use tools from the chip manufacturer, this is usually
 accessed via the "debug" button. I plan to use OpenOCD for on-chip debugging.

## Compiler / linker
1. Search for gnu-rm.
  I last found them at:
  https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads
1. Extract the tar file into a suitable folder. Eg. $HOME/gnu-rm
1. Set PATH to point to the gnu-rm bin folder.

## Code development
Compilers like gcc generate code object files that have
assignable start addresses -- relocatable object files.

For these files to properly run on the device, these
start addresses must be defined and assigned.
This is the job of the linker script, MKL05Z4.ld .

The first executable to run is startup_MKL05Z4.s .
This is an assembler file provided by me, the system
implementer.

### startup_MKL05Z4.s
startup_MKL05Z4.s has to do at least two things:
1. tell the linker where to put startup code when the device powers up or resets.
  i.e. the reset vector.
1. have the reset vector call SystemInit() .
  void SystemInit(void) is a c function provided by me to initialise the system.
  SystemInit() resides in the file system_MKL05Z4.c

startup_MKL05Z4.s should also tell the linker to
set up the stack which is used to store function return
addresses and also the heap where local variables are kept. I have glossed
over these for the time being to focus on main concepts.

My commented startup_MKL05Z4.s file is at:
https://github.com/siuyin/arm-from-scratch/blob/master/mkl05z4/startup_MKL05Z4.s

### MKL05Z4.ld
MKL05Z4.ld is the linker script which directs the linker on
how to place objects files to create the executable file.

### MKL05Z4.h
If you use the manufacturer's device c header file (eg. MKL05Z4.h), it will almost always also
include CMSIS core header files. This means learning CMSIS. See:
https://arm-software.github.io/CMSIS_5/Core/html/index.html .

MKL05Z4.h is the manufacturer provided device
c header file and it includes core_cm0plus.h and system_MKL05Z4.h .

**core_cm0plus.h** provides declarations for the basic run-time system for a Cortex-M device.
Specifically it provides a standardized SystemInit() function to configure the clock
system of the device.

core_cm0plus.h also provides intrinsic functions used to generate CPU instructions that
are not supported by standard C functions.

Thus core_cm0plus.h itself includes core_cmFunc.h and core_cmInstr.h .

**core_cmFunc.h** determines which compiler you are using and includes
the relevant header file. In my case, as I am using GCC, it will include
cmsis_gcc.h . 

**cmsis_gcc.h** defines standardised _functions_ such as `__enable_irq()` / `__disable_irq()`
and standardised 'assembler'  _instructions_ like  `__NOP()`.

Thus **core_cmInstr.h** also includes the relevent compiler header file, cmsis_gcc.h
in my case, to define standardised instructions.

### system_MKL05Z4.h
system_MKL05Z4.h and system_MKL05Z4.c are the c header file and implementation
for the startup routines. These files are provided by me, the 
microcontroller system designer.

To comply with CMSIS, system_MKL05Z4 must:
- implement void SystemInit(void) : to initialise the system, especially its clock system
- update global variable `uint32_t SystemCoreClock` with the system core clock frequency.


## Programming (flash) tool
The FRDM-KL05Z board has a built-in CMSIS-DAP (Cortex Microcontroller Software Interface Standard - Debug
Access Port). To program the on-board or connected device:
1. plug in the FRDM-KL05Z board, this will show up as a USB drive "MBED"
1. copy the .bin or .hex binary to the MBED folder
1. press the reset button on the board to run your code
