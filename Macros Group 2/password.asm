   
;Below is a macro that compares password given and password stored then prints correct if same and incorrect if not equal
   ;we declare the systems calls and store them in variables
    SYS_READ equ 3
    SYS_EXIT equ 1
    SYS_WRITE equ 4
    STDOUT equ 1
    STDIN equ 0

    ;we create the first macro write which has 2 parameters and dispays on the screen
    %macro write 2

            mov eax, SYS_WRITE
            mov ebx, STDOUT
            mov ecx, %1
            mov edx, %2
            int 80h

    %endmacro
    
    ;we then create the second macro read which has 2 parameters and reads the user input ie the password 
    %macro read 2

            mov eax, SYS_READ
            mov ebx, STDIN
            mov ecx, %1
            mov edx, %2
            int 80h
    %endmacro

    ;create changeFormat macro that converts the the numbers from ascii to numerical numbers
    %macro changeFormat 2
            mov eax, %1 ; move the pass variable into eax
            sub eax, '0' ; change the ascii number in eax to a numerical number
            mov ebx, %2 ; move the thepass variable into ebx
            sub ebx, '0' ; change the ascii number in ebx to a numerical number
    %endmacro

     %macro exit_system 0
            mov eax, SYS_EXIT
            int 80h
    %endmacro

    ;create macro comparePass that will compare the two password
    %macro comparePass 0
        cmp eax, ebx ; compare the 2 numbers

        ;create two labels correct and incorrect
        je %%correct ; if they are equal, jump to correct label
        jmp %%incorrect ; if not, jump to incorrect label

    
        ;correct label displays that the password is correct by invoking the write macro and passing the corr variable
        %%correct:

                write corr, len_corr

                exit_system
        
        ;incorrect label displays that the password is incorrect by invoking the write macro and passing the incor variable
        %%incorrect:

                write incor, len_incor

                exit_system
    %endmacro

   

section .text
    global _start
_start:

    ;We invoke the micros written passing in the variable as the oarameters of the macro
    write whatis, len_whatis

    read pass, 5

    changeFormat [pass], [thepass]
    
    comparePass

   
section .data
    
    ;Declare the variables in this sections
    whatis db "What is the password?", 0xA
    len_whatis equ $ - whatis

    thepass db "12345"

    corr db "Correct!", 0xA
    len_corr equ $ - corr

    incor db "Incorrect!", 0xA
    len_incor equ $ - incor

section .bss
    pass resb 5
