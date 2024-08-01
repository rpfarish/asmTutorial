section .data
    fizz dq "Fizz", 10, 0
    buzz dq "Buzz", 10, 0
    newline dq 10, 0
    num dq 100


section .bss
    digit_space resb 100
    digit_space_pos resb 8
 

section .text
global _start

_start:
    mov r10, 0
        
loop:
    mov r9, 0
    mov rax, [num]
    cmp r10, rax
    jge end
    inc r10

    ; fizz
    mov rax, r10        
    xor rdx, rdx    ; remainder               
    mov rbx, 3          
    div rbx

    cmp rdx, 0
    je print_fizz
fizz_return:

    ; buzz
    mov rax, r10     
    xor rdx, rdx    ; remainder       
    mov rbx, 5       
    div rbx       
    cmp rdx, 0
    je print_buzz

buzz_return:
    cmp r9, 0
    je print_nums
    jmp print_newline

print_nums:    
    mov rax, r10
    call _print_RAX
    jmp loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print_fizz:
    inc r9
    lea rsi, [fizz]
    mov rdx, 5
    mov rax, 1 ; sys_write
    mov rdi, 1 ; sys_out
    syscall
    jmp fizz_return

print_buzz:
    inc r9
    lea rsi, [buzz]
    mov rdx, 5
    cmp rdx, 0
    mov rax, 1 ; sys_write
    mov rdi, 1 ; sys_out
    syscall
    jmp buzz_return

print_newline:
    mov rax, 1 ; sys_write
    mov rdi, 1 ; sys_out
    lea rsi, [newline]
    mov rdx, 1
    syscall
    jmp loop

  
_print_RAX:
    mov rcx, digit_space
    mov rbx, 10
    mov [rcx], rbx
    inc rcx
    mov [digit_space_pos], rcx
 
_printRAXLoop:
    mov rdx, 0
    mov rbx, 10
    div rbx
    push rax
    add rdx, 48
 
    mov rcx, [digit_space_pos]
    mov [rcx], dl
    inc rcx
    mov [digit_space_pos], rcx
    
    pop rax
    cmp rax, 0
    jne _printRAXLoop
 
_printRAXLoop2:
    mov rcx, [digit_space_pos]
 
    mov rax, 1
    mov rdi, 1
    mov rsi, rcx
    mov rdx, 1
    syscall
 
    mov rcx, [digit_space_pos]
    dec rcx
    mov [digit_space_pos], rcx
 
    cmp rcx, digit_space
    jge _printRAXLoop2
 
    ret


end:
    mov rax, 60
    mov rdi, 0
    syscall
