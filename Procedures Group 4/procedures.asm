section    .text
   global _start        
    
_start:                   
   mov      ecx,'5'	; initialize ecx register for value 5
   sub  ecx, '0'
    
   mov  edx, '4'	; initialize edx register for value 4
   sub  edx, '0'
 call    sum         ;call procedure
   mov [res], eax
   mov     ecx, msg    
   mov     edx, len
   mov ebx,1            ;file descriptor (stdout)
   mov     eax,4            ;system call number (sys_write)
   Int     0x80             
    
   mov    ecx, res
   mov     edx, 1
   mov     ebx, 1            ;file descriptor (stdout)
   mov     eax, 4            ;system call number (sys_write)
   int     0x80      
   mov    eax,1            ;system call number (sys_exit)
   int    0x80            ;call kernel

sum:			;procedure definition
   mov     eax, ecx
   add     eax, edx
   add     eax, '0'
   ret    

section .data
msg db "The sum is:", 0xA,0xD 
len equ $- msg   
segment .bss
res resb 1

