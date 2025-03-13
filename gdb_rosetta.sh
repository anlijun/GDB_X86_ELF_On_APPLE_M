#!/bin/bash

# This script facilitates debugging of x86 processes on Apple M-series chips using ROSETTA's built-in gdb_server.
# It starts the specified program in the background with the given arguments, sets up a gdb_server on port 1234,
# and then launches GDB with an initialization script to connect to the gdb_server and set a breakpoint at main.

# Usage: ./gdbm.sh <program> [arguments...]
# Example: ./gdbm.sh ./my_x86_program arg1 arg2

# To see this help message, run:
# ./gdbm.sh -help

# Check if the -help flag is provided
if [ "$1" = "-help" ]; then
    echo "Usage: $0 <program> [arguments...]"
    echo "This script starts the specified program in the background with the given arguments,"
    echo "sets up a gdb_server on port 1234 using ROSETTA, and launches GDB to connect to it."
    echo "It is designed for debugging x86 processes on Apple M-series chips."
    exit 0
fi

# Capture the name of the program to be debugged
PROGRAM=$1
shift

# Check if a program was specified
if [ -z "$PROGRAM" ]; then
    echo "Error: No program specified."
    echo "Usage: $0 <program> [arguments...]"
    exit 1
fi

# Start the program in the background with the given arguments and set the debug server port
ROSETTA_DEBUGSERVER_PORT=1234 "$PROGRAM" "$@" &

# Create a temporary file for the GDB initialization script
GDB_INIT=$(mktemp)

# Write GDB commands to the initialization script
echo "target remote :1234" > "$GDB_INIT"
echo "b main" >> "$GDB_INIT"
echo "c" >> "$GDB_INIT"

# Start GDB using the initialization script
gdb -x "$GDB_INIT" "$PROGRAM"

# Clean up the temporary file
rm "$GDB_INIT"
