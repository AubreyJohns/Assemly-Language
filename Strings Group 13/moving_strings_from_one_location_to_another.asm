;the following code demonstrates how the MOV instruction can be used to the source string is pointed by DS:SI, and the destination string is pointed by ES:DI
section .data
  s1 db 'Hello World', 0 ; source string location
  len equ $-s1          ;declaring the length of s1

section .bss
  s2 resb 20            ; destination String location. Its here because were using s2 like a variable since we need to write here after the '_start:' is called in the section .text

section .text
    global _start
_start:             ; entry point(obviously)
    mov ecx, len    ;sets the length of our s1 string
    mov esi, s1     ;sets the s1 in the esi(as our source string location)
    mov edi, s2     ;sets the s2 in the edi(as our destination string location)
    cld             ;clears the direction flag, making data to go forwards
    rep movsb       ;repeats the movsb string operation the number of times weve defined in our ecx

    ;Here were just displaying whats in our destination string location s2
    mov edx, 20     ;message length
    mov ecx, s2     ;message to write
    mov ebx, 1
    mov eax, 4
    int 0x80        ;calling the kernel

    ;exit
    mov eax, 1
    int 0x80
