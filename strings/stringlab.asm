
SECTION .data

str1 db 'please enter your name: ', 0h		;string asking for user input.
str2 db 'Welcome to Assembly Programming, ', 0h ;final string after entering your name.

;function to calculate string length.
strlen:
	push ebx
	mov ebx, eax

nextchar:
	cmp byte [eax], 0
	jz end
	inc eax
	jmp nextchar

end:
	sub eax, ebx
	pop ebx
	ret	;return from procedure.

;function to print the string.
strout:
	push edx
	push ecx
	push ebx
	push eax
	call strlen

	mov edx, eax
	pop eax

	mov ecx, eax
	mov ebx, 1
	mov eax, 4
	int 80h

	pop ebx
	pop ecx
	pop edx
	ret

SECTION .bss
 reserveb: resb 200 ;reserve bytes.

SECTION .text
global _start

	_start:

	mov eax, str1
	call strout

	mov edx, 200
	mov ecx, reserveb ;reserved space
	mov ebx, 0	;write to input file
	mov eax, 3	;sys_read
	int 80h

	mov eax, str2
	call strout

	mov eax, reserveb
	call strout

	mov ebx, 0
	mov eax, 1
	int 80h
	ret


