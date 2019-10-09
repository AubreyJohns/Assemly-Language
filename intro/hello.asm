section .text
global _start
_start:

section .bss
section .data
msg db 'Hello, world!' ,10,0
len equ $ -msg



;section .data
;message db 'Hello, this is my first program.' ,0xa      ;an output 
;messageLength equ $ -message     ;this is the message
;message1 db 'I am in ICS 3B.'     ,0xa  ;an output
;messageLength1 equ $ -message1     ;this is the message

;section .bss

;section .text
;       global _start
;         _start:
;           mov edx, messageLength
;           mov ecx, message
;           mov ebx, 1
;           mov eax, 4
;           int 80h           ;try 0*80 if the current doesn't work

;           mov edx, messageLength1
;           mov ecx, message1
;           mov ebx, 1
;           mov eax, 4
;           int 80h
