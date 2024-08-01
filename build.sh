#!/bin/bash
if [ -e $1.s ]
then
echo "Filename: $1.s"
echo "Compiling..." 
nasm -f elf64 -o $1.o $1.s
echo "Output File Format: elf64"
elif [ -e $1.asm ]
then
echo "Filename: $1.asm"
echo "Compiling..." 
nasm -f elf64 -o $1.o $1.asm
echo "Output File Format: elf64"
else
echo "No supported file format found"
exit 1
fi
echo "Linking..."
ld $1.o -o $1
echo "Running: $1"
./$1
echo "Exit code: $?"
