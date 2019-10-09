section .data
s1 db 'Hello World', 0 ; string 1
len equ $-s1

section .bss
s2 resb 20

section .text
    global _start
     _start: ; entry point
    mov ecx, len
    mov esi, s1
    mov edi, s2
    cld
    rep movsb
    mov edx, 20 ;message length
    mov ecx, s2 ;message to write
    mov ebx, 1
    mov eax, 4
    int 0x80
    mov eax, 1
    int 0x80
