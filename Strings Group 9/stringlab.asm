
SECTION .data

str1 db 'please enter your name: ', 0h		;string asking for user input.
str2 db 'Welcome to Assembly Programming, ', 0h ;final string after entering your name.

;function to calculate string length.
strlen:
	push ebx			;push contents of register ebx to the stack

	mov ebx, eax			;move contents of register eax to ebx

nextchar:
	cmp byte [eax], 0		;compare bytes in eax if it is equal to 0
	jz end				;if bytes == 0, jump to the procedure end
	inc eax				;if bytes in eax != 0, increment eax
	jmp nextchar			;we repeat the procedure until bytes in eax == 0

end:
	sub eax, ebx			;subtract contents of ebx from eax
	pop ebx				;pop ebx from the stack
	ret				;return from procedure.

;function to print the string.
strout:
	push edx			;push edx to the stack
	push ecx			;push ecx to the stack
	push ebx			;push ebx to the stack
	push eax			;push eax to the stack
	call strlen			;call the procedure strlen

	mov edx, eax			;move eax contents to edx
	pop eax				;pop eax from the stack

	mov ecx, eax			;move eax contents to ecx
	mov ebx, 1 			;sys_exit
	mov eax, 4			;sys_write
	int 80h				;interrupt

	pop ebx				;pop ebx contents from the stack
	pop ecx				;pop ecx contents from the stack
	pop edx				;pop edx contents from the stack
	ret 				;return from procedure
SECTION .bss
 reserveb: resb 200 			;reserve bytes.

SECTION .text
global _start

	_start:

	mov eax, str1			;move str1 to register eax
	call strout			;print string 1

	mov edx, 200
	mov ecx, reserveb 		;reserved space
	mov ebx, 0			;write to input file
	mov eax, 3			;sys_read
	int 80h				;interupt

	mov eax, str2			;move str2 to register eax
	call strout 			;print string 2

	mov eax, reserveb		;reserved space
	call strout 			;prints final string	

; exit program
	mov ebx, 0			
	mov eax, 1			;sys_exit
	int 80h				;interrupt
	ret				;return from procedure


