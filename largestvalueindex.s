.globl _start          # Makes _start symbol globally visible (entry point)

.section .data         # Initialized data section
numberofnumbers:
    .quad 7            # 64-bit (quad) value storing the count of numbers (7 elements)

mynumbers:
    .quad 5, 20, 33, 80, 52, 10, 1  # Array of 64-bit integers (quad words)

.section .text         # Code section
_start:
    movq numberofnumbers, %rcx  # Load array length (7) into RCX (loop counter)
    movq $0, %rbx       # Initialize RBX to 0 (array index)
    movq $0, %rdi       # Initialize RDI to 0 (will store the maximum value)

    cmp $0, %rcx        # Check if the array is empty (RCX == 0)
    je endloop          # If empty, skip loop and exit

myloop:
    movq mynumbers(,%rbx,8), %rax  # Load current array element into RAX
                      # Addressing: mynumbers + RBX * 8 (scale by 8 bytes per quad)
    cmp %rdi, %rax    # Compare current element (RAX) with current max (RDI)
    jbe loopcontrol   # If RAX <= RDI (unsigned comparison), skip update

    movq %rax, %rdi   # Update RDI with the new maximum value (RAX > RDI)

loopcontrol:
    incq %rbx         # Increment array index (RBX += 1)
    loopq myloop      # Decrement RCX. If RCX != 0, jump back to myloop

endloop:
    movq $60, %rax    # Set syscall number for exit (60 = sys_exit)
    syscall           # Invoke kernel to terminate the program
