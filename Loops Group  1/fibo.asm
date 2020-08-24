section .bss
    current resb 1
    previous resb 1

section .text
    global _start
    _start:

    mov ebx, 0 ;previous
    mov ecx, 5 ;counter
    mov eax, 1 ;used to store the next number to be printed
    
    mov [previous], ebx ; Initialize previos to 0
    
    l1: 
        mov [current], eax ; Previous value of eax is current
        add eax, [previous] ; New eax = current + previous

        mov edx, [current] ; previous = current
        mov [previous], edx

        add eax, '0' ;Convert from decimal to ASCII 
        mov [current], eax ; This will be the next number to be displayed
        sub eax, '0'; Convert from ASCII to decimal

        push eax    ; Store the value of eax to stack because the register will be used for printing

        mov eax, 4
        mov ebx, 1
        push ecx ; Store the counter in stack before resetting ecx
        mov ecx, current
        mov edx, 1
        int 80h

        pop ecx ;Restore the counter
        pop eax ;Restore the value of eax
        loop l1

    mov eax, 1
    int 80h

    ; Did not work , giving 11111 as output
