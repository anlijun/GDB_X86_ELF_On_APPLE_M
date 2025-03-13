# GDB_X86_ELF_On_APPLE_M

## Functionality

This shell script simplifies the debugging of virtual x86 processes on Apple M-series chips. It automates the following steps:

1. Starts the specified x86 program in the background with the given arguments, using ROSETTA's gdb_server on port 1234.
2. Creates a temporary GDB initialization script that connects to the gdb_server, sets a breakpoint at `main`, and continues execution.
3. Launches GDB with the initialization script to begin debugging.

## Background

Apple M-series chips use ROSETTA to emulate the x86 architecture for running x86 Docker processes. To debug these processes with GDB, it is necessary to utilize ROSETTA's built-in gdb_server. This script provides a convenient way to start the debugged program and pass its startup arguments while setting up the debugging environment.


## Usage

To use the script, run:


```bash
./gdb_rosetta.sh <program> [arguments...]
```


## Troubleshooting & Environmental Check

Make sure you are in an x86 shell and that x86 gdb is installed.

```bash
gdb -q -batch --eval-command="show architecture; quit"
The target architecture is set to "auto" (currently "i386").
```


## What is Rosetta?
Rosetta 2, introduced in 2020 as a component of macOS Big Sur, is part of the Mac transition from Intel processors to Apple silicon, allowing Intel applications to run on Apple silicon-based Macs.
