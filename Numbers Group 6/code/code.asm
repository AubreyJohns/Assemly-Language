%include "lib/lib.asm" ; to include cout, cin, define_byte, exit
%include "lib/math.asm" ; to include multiply_nums, add_nums
section .text
  global _start
_start:
  cout message, length
  cin_num num, 4

  cout message1, length1
  cin_num num1, 4

  cout result, len

  subtract_nums mult, mult_len
  
  cout mult, mult_len
 
  exit 0
section .bss
  num resw 2
  num1 resw 2
  mult resw 4
  mult_len resw 2
section .data
  define_byte message, 'Enter a Number: ', length 
  define_byte message1, 'Enter Another Number: ', length1
  define_byte result, 'Result is: ', len
  
  
