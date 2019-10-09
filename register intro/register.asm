section .data
message db 'First character in my name.' ,0xa      ;an output 
messageLength equ $ -message     ;this is the message
firstChar times 4 db 'Aubrey' ,0xa


section .bss

section .text
 global _start
  _start:
  mov edx, messageLength
  mov ecx, message
  mov ebx, 1
  mov eax, 4
  int 80h           ;try 0*80 if the current doesn't work
 
  mov ecx, firstChar
  mov eax, 4
  int 80h

  mov eax, 1
  int 80h
