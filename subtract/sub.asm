SYS_READ equ 3
SYS_WRITE equ 4
SYS_EXIT equ 1
SYS_IN equ 0
SYS_OUT equ 1

section .text
 global _start
  _start:
   mov eax, SYS_WRITE
   mov ebx, SYS_OUT
   mov ecx, prompt
   mov edx, lenPrompt
   int 80h

   mov eax, SYS_READ
   mov ebx, SYS_IN
   mov ecx, firstNumber
   mov edx, 2
   int 80h


   mov eax, SYS_WRITE
   mov ebx, SYS_OUT
   mov ecx, prompt_1
   mov edx, lenPrompt_1
   int 80h

   mov eax, SYS_READ
   mov ebx, SYS_IN
   mov ecx, secondNumber
   mov edx, 2
   int 80h


   mov eax, [firstNumber]
   sub eax, '0'

   mov ebx, [secondNumber]
   sub ebx, '0'

   sub eax,ebx
   add eax, '0' ;convert back to ASCII

   mov [result], eax


   mov eax, SYS_WRITE
   mov ebx, SYS_OUT
   mov ecx, prompt_2
   mov edx, lenPrompt_2
   int 80h

   mov eax, SYS_WRITE
   mov ebx, SYS_OUT
   mov ecx, result
   mov edx, 2
   int 80h

   mov eax, SYS_EXIT
   int 80h


section .data
 prompt db "Enter first number: " ,0xa
 lenPrompt equ $ -prompt

 prompt_1 db "Enter second number: " ,0xa
 lenPrompt_1 equ $ -prompt_1

 prompt_2 db "Result: " ,0xa
 lenPrompt_2 equ $ -prompt_2

section .bss
 firstNumber resb 2
 secondNumber resb 2
 result resb 2
