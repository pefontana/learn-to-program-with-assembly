.globl _start

.section .text
_start:
    movb $0b00100010, %al
    movb $0b01110100, %bl
    seto %al               # AL = 1 si CF=1, 0 si CF=0
    movzbq %al, %rdi      
	movq $60, %rax
	syscall
