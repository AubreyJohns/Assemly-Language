;the following code can be used to encrypt data by simply replacing each alphabet in it with a shift of two alphabets(eg a->c, b->d and such) using LODS
section .text
global main   ;must be declared for using gcc
main:
  ;tell linker entry point
    mov ecx, len
    mov esi, s1
    mov edi, s2

  loop_here:
    lodsb           ;loads the character to be shifted
    add al, 02      ;shifts the character to the character after the next one(eg a->c)
    stosb           ;stores the new character in the position
    loop loop_here  ;restarts the loop
    cld             ;clears the direction flag, making data to go forwards(as opposed to STD or SeTs Direction flag, where data goes backwards)
    rep movsb       ;repeats the movsb string operation the number of times weve defined in our ecx(notice how we set ecx to be the length of s1, our string as a password)

    ;here, the encrypted password is simply displayed.
    mov edx,20  ;message length
    mov ecx,s2  ;message to write
    mov ebx,1   ;file descriptor (stdout)
    mov eax,4   ;system call number (sys_write)
    int 0x80    ;call kernel

    mov eax,1   ;system call number (sys_exit)
    int 0x80    ;call kernel

  section .data
    s1 db 'password', 0 ;source password string. Replace with anything you like
    len equ $-s1

  section .bss
    s2 resb 10          ;destination for the encrypted string. Stored here because we are using it like a variable and not a constant.
