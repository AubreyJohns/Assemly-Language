;Print to console
%macro cout 2
   mov eax, 4  ;SYS_WRITE
   mov ebx, 1  ;STDOUT
   mov ecx, %1 ;message to print
   mov edx, %2 ;length of message to print
   int 0x80
%endmacro

%macro incr_num 0
   mov eax, [num] ;eax = num
   sub eax, '0' ;to decimal
   inc eax      ;eax++
   add eax, '0' ;to ascii
%endmacro

%macro decr_counter 0
   pop ecx ;restore the original value of the ecx from the stack
   loop l1 ;return to start of loop if ecx != 0
%endmacro

%macro do_sum 0
   mov eax, [num] ;eax = num 
   sub eax, '0' ;num to decimal
   
   mov ebx, [sum]; ebx = sum
   
   add eax, ebx ;eax = eax + ebx
   mov [sum],eax ;Store the sum in sum variable
%endmacro

%macro do_sub 0
   mov eax, [sum]       ;eax = sum
   mov ebx, [counter]   ;ebx = counter
   sub eax, ebx         ;eax = eax = ebx
   mov [sum],eax        ;Store the sum in sum variable
%endmacro


%macro print_sum 0
   mov eax, [sum]
; Convert the sum decimal to a string
    mov edi, sum                ; Argument: Address of the target string
    call int2str                ; Get the digits of EAX and store it as ASCII
    sub edi, sum                ; EDI (pointer to the terminating NULL) - pointer to sum = length of the string
    mov [sum_len], edi          ; store length of the sum in sum_len

   cout sum_msg, sum_msg_len    ;Print sum_msg
   cout sum, [sum_len]          ;Print sum
%endmacro

section	.bss
   num resb 1
   sum_len resd 1

section .data
   counter dd 10 ;init counter
   sum dd 0

   sum_msg db 'The sum is: ',0xa
   sum_msg_len equ $ - sum_msg

section	.text
   global _start        ;must be declared for using gcc
	
_start:	                ;tell linker entry point
   mov ecx, [counter]
   mov eax, '1'

l1:;start of loop
      push ecx ;Store the ecx (counter) value in stack 
      
      mov [num], eax ;num = eax value

      cout num, 1 ;print num
      
      do_sum    ;sum = sum + num 

      incr_num  ;num++

   decr_counter ;End of loop body (ecx --) 

   do_sub ;sum = sum - counter

   print_sum ;print_sum

   ;exit
   mov eax,1             ;system call number (sys_exit)
   int 0x80              ;call kernel

int2str:    ; Converts an positive integer in EAX to a string pointed to by EDI
    xor ecx, ecx
    mov ebx, 10
    .LL1:                   ; First loop: Save the remainders
    xor edx, edx            ; Clear EDX for div
    div ebx                 ; EDX:EAX/EBX -> EAX Remainder EDX
    push dx                 ; Save remainder
    inc ecx                 ; Increment push counter
    test eax, eax           ; Anything left to divide?
    jnz .LL1                ; Yes: loop once more

    .LL2:                   ; Second loop: Retrieve the remainders
    pop dx                  ; In DL is the value
    or dl, '0'              ; To ASCII
    mov [edi], dl           ; Save it to the string
    inc edi                 ; Increment the pointer to the string
    loop .LL2               ; Loop ECX times

    mov byte [edi], 0       ; Termination character
    ret                     ; RET: EDI points to the terminating NULL



