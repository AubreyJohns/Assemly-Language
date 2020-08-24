;The following demonstrates use of the LODS and STOS instruction to convert an upper case string to its lower case value
section .text
global main          ;must be declared for using gcc
main:
    mov ecx, len     ;sets the length of our source string s1
    mov esi, s1      ;indicates our source string
    mov edi, s2      ;indicates the destination string
loop_here:
    lodsb            ;loads the character
    or al, 20h       ;shifts the character to its uppercase version
    stosb            ;stores the uppercase character
    loop loop_here   ;restarts the loop

    cld              ;clears the direction flag, making data to go forwards
    rep movsb        ;repeats the movsb string operation the number of times weve defined in our ecx(notice how we set ecx to be the length of s1, our string in uppercase)

    ;Displaying the result of our function after shifting the s1 characters to lowercase and storing them in s2
    mov edx, 20
    mov ecx, s2
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Exiting
    mov eax, 1
    int 0x80

section .data
s1 db 'HELLO ICS', 0  ;source string in caps
len equ $-s1          ;its length

section .bss
s2 resb 10          ;destination string location after converted to lowercase
