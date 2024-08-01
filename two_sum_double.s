section .data
    ;list dq 2,7,11,15      ; target 5
    ;list dq 3,2,4          ; target 6
    ;list dq 3,3            ; target 6
    ;list dq -3,4,3,90      ; target 0
    list dq -1,-2,-3,-4,-5  ; target -8
    list_len equ $ - list
    target dq -8

section .text
global _start

_start:
    mov rax, list_len
    shr rax, 3
    mov r8, rax       ; list len 4
    mov r9, 0
    mov r10, 1
    mov rdx, [target]
loop:
    ; cmp val at index 1 and 2
    mov rbx, [list + 8 * r9]
    mov rcx, [list + 8 * r10]
    add rbx, rcx
    cmp rbx, rdx
    je end 

    inc r10
    cmp r10, r8 ; check first pointer is at end of list
    jge inc_pointers_from_end
    jmp loop

inc_pointers_from_end:
    cmp r9, r8 - 1
    jge end
    inc r9
    mov r10, r9
    inc r10
    jmp loop



end:    
    mov rax, 60
    mov rdx, 1
    syscall
