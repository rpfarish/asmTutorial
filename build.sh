echo "Filename: $1"

nasm -f elf64 -o $1.o $1.s
ld $1.o -o $1
./$1
echo "Exit code: $?"
