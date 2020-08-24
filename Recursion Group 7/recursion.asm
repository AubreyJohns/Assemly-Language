SYS_EXIT EQU 1
SYS_WRITE equ 4
SYS_READ equ 3
SYS_IN equ 0
SYS_OUT equ 1

section	.data
msg db 'Enter value to get factorial:',0xa	
len equ $ - msg			

section .bss
value resd 2
fact resd 2


section	.text
   global _start       
	
_start:    
        
	;code to display the message for entering factorial    
	mov eax, SYS_WRITE	;system call number (sys_write)
	mov ebx, SYS_OUT	;file descriptor (stdout)
	mov ecx, msg		;message to write 
	mov edx, len		;message length
	int 80h			;call kernel
	;to take in the value input by the user
	mov eax, SYS_READ
	mov ebx, SYS_IN
	mov ecx, value
	mov edx, 2
	int 80h  

	mov ebx, [value] ;moved to convert it from ascii to decimal
	sub ebx, '0'
   	call  proc_fact
        mov edi, fact
        call writeString
        int 80h

   mov   edx,6        ;message length
   mov	  ecx,fact       ;message to write
   mov	  ebx,1          ;file descriptor (stdout)
   mov	 eax,SYS_WRITE          ;system call number (sys_write)
   int	  0x80           ;call kernel
    
   mov	  eax,1          ;system call number (sys_exit)
   int
.	  0x80           ;call kernel
	
proc_fact:
   cmp   bl, 1
   jg    do_calculation
   
   mov   eax, 1
   ret
	
do_calculation:
   dec   bl
   call  proc_fact
   inc   bl
   imul   bl        ;eax = al * bl
   ret

writeString:
  xor ecx, ecx ; counter
  mov ebx, 10 ; base
  .loop1:
    xor edx, edx ; clear edx register (remainder)
    div ebx ; divide number with base
    push edx ; push remainder to stack
    inc ecx ; increment the counter
    test eax, eax
    jnz .loop1
  .loop2:
    pop edx
    add edx, '0'
    mov [edi], edx
    inc edi
    loop .loop2
   mov byte [edi], 0xa
   inc edi
   mov byte [edi], 0
   ret
    




