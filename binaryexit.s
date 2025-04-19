.section .text
.globl _start
_start:
    movq $0b1111110, %rdi
    movq $60, %rax
    syscall 
