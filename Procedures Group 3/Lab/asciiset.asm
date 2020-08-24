section	.text
   global _start     ;must be declared to use gcc

   _start:           ;tell linker entry point
      call display   ;call procedure name =>display
         mov eax,1   ;syscall for sysexit
         int 0x80    ;kernel call

      display:       ;display procedure
      mov ecx, 256   ;move 256(no. of ascii elements) to 16 bit register

   next:             ;loop for each character of ascii number system
   push ecx          ;push what is in the accumulator to the stack
   mov eax, 4        ;syscall for syswrite
   mov ebx, 1        ;file descryptor
   mov ecx, achar    ;move character to register 16 bit register ecx
   mov edx, 1        ;length of the string to be displayed
   int 80h           ;kernel call

   pop ecx                 ;pop element from stack
   mov dx, [achar]         ; move character to 8 bit register
   cmp byte [achar], 0dh   ;complement of current value and positioning cursor at the beginning of current line
   inc byte [achar]        ;increment value
   loop next               ;next value 
   ret                     ;return call

   section .data
   achar db '0'   ;Double-word saved into the stack