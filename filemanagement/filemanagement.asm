section .data
file_name db 'myfile.txt'
message db 'Welcome to the file management presentation', 0xa
length equ $ -message
message_done db 'Written to the file', 0xa
length_done equ $ -message_done

section .text
 global _start
  _start:
; creating our file
MOV eax, 8
MOV ebx, file_name
MOV ecx, 0777  ; read, write and execute by all
int 80h
MOV [fd_out], byte eax

; write into our file
MOV edx, length  ; maximum number of bytes
MOV ecx, message ; message to write
MOV ebx, [fd_out] ; file descriptor
MOV eax, 4        ; stsrem call
int 80h

; close the file
MOV eax, 6   ; system call
MOV ebx, [fd_out] ; file descriptor

; write a message to indicate end of file
MOV eax, 4
MOV ebx, 1
MOV ecx, message_done
MOV edx, length_done
int 80h

; open for reading
MOV eax, 5   ; system call
MOV ebx, file_name
MOV ecx, 0    ; file access mode
MOV edx, 0777  ; file permission rwx for all
int 80h
MOV [fd_in], byte eax

; read from the file
MOV eax, 3  ; system call
MOV ebx, [fd_in]
MOV ecx, info   ; pointer to the buffer
MOV edx, 43  ; buffer size
int 80h

; close the file
MOV eax, 6   ; system call
MOV ebx, [fd_in] ; file descriptor

; print the information that's in the file
MOV eax, 4
MOV ebx, 1
MOV ecx, info
MOV edx, 43
int 80h

MOV eax, 1  ; system call number

int 80h    ; call the kernel

section .bss  
fd_out resb 1   ; file descriptor (Standart Output)
fd_in resb 1    ; file descriptor (Standard Input)
info resb 43    ; to hold our message length
