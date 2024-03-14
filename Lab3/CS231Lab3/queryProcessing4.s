.data

array: .space 40000   # Declaring our array
newline: .asciiz "\n"
debugger: .asciiz "check \n"
debugger2: .asciiz "check2 \n"
debugger3: .asciiz "check3 \n"
debugger4: .asciiz "check4 \n"
debugger5: .asciiz "check5 \n"
space: .asciiz " "
mid: .asciiz "mid = "
print_t4: .asciiz "t4 = "
print_t5: .asciiz "t5 = "
print_t1: .asciiz "t1 = "
print_t3: .asciiz "t3 = "
print_s0: .asciiz "s0 = "
print_s1: .asciiz "s1 = "
print_s6: .asciiz "s6 = "
for: .asciiz "In for loop \n"
while: .asciiz "In while loop \n"
came_out_for: .asciiz "Came out of for\n"
came_out_while: .asciiz "Came out of while\n"
came_out_merge: .asciiz "Came out of merge\n"
.text
.globl main

arrayInput:
    beq $t0, $s4, exitLoop
    li $v0, 5
    syscall

    move $s0, $v0
    sw $s0, array($t0)

    addi $t0, $t0, 4
    j arrayInput

arrayPrint:
    beq $t0, $s4, exitPrint
    
    li $v0, 1
    lw $a0, array($t0)
    syscall

    li $v0, 4
    la $a0, space
    syscall

    addi $t0, $t0, 4
    j arrayPrint

exitPrint:
    li $v0, 4
    la $a0, newline
    syscall
    jr $ra

mergeSort:
    # is $s0 is f
    # is $s1 is b
    slt $t1, $s0, $s1
    beq $t1, 0, exitLoop

    li $v0, 4
    la $a0, print_s0
    syscall
    li $v0, 1
    move $a0, $s0
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, print_s1
    syscall
    li $v0, 1
    move $a0, $s1
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    add $t1, $s0, $s1
    li $t2, 2
    div $t1, $t2
    mflo $s3

    addi $sp, $sp, -8
    sw $ra, 0($sp)  # The return address
    sw $s1, 4($sp) # pointer to end

    move $s1, $s3
    jal mergeSort
    
    lw $ra, 0($sp)
    lw $s1, 4($sp)

    sw $ra, 0($sp)
    sw $s0, 4($sp)
    
    addi $t1, $s3, 1
    move $s0, $t1
    jal mergeSort

    lw $ra, 0($sp)
    lw $s0, 4($sp)

    addi $sp, $sp, 8

    addi $sp, $sp, -4
    sw $ra, 0($sp)

    jal merge

    lw $ra, 0($sp)
    addi $sp, $sp, 4  
    
    jr $ra

merge:
    # Here we use $t1 as left_ptr
    #         and $t2 as right_ptr
    #         and $t3 as mid

    move $t1, $s0
    addi $t2, $s3, 1
    move $t3, $s3

    addi $sp, $sp, -4
    sw $ra, 0($sp)

    jal while_loop

    li $v0, 4
    la $a0, came_out_while
    syscall

    lw $ra, 0($sp)
    addi $sp, $sp, 4

    jr $ra


while_loop:
    li $v0, 4
    la $a0, while
    syscall

    sle $t4, $t1, $t3
    sle $t4, $t1, $t3
    sle $t5, $t2, $s6
    and $t4, $t4, $t5
    beq $t4, 0, exitLoop

    li $v0, 4
    la $a0, print_t1
    syscall
    li $v0, 1
    move $a0, $t1
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, print_t3
    syscall
    li $v0, 1
    move $a0, $t3
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    li $t8, 4
    mult $t1, $t8
    mflo $t8
    lw $t4, array($t8)

    li $v0, 4
    la $a0, print_t4
    syscall
    li $v0, 1
    move $a0, $t4
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    li $t8, 4
    mult $t4, $t8
    mflo $t8
    lw $t5, array($t8)

    li $v0, 4
    la $a0, print_t5
    syscall
    li $v0, 1
    move $a0, $t5
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    ble $t4, $t5, less
    # Now we use $t4 as the temp variable
    li $t8, 4
    mult $t2, $t8
    mflo $t8
    lw $t4, array($t8)

    addi $sp, $sp, -4
    sw $ra, 0($sp)

    move $t5, $t2
    jal for_loop
    li $v0, 4
    la $a0, came_out_for
    syscall

    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    li $t8, 4
    mult $t1, $t8
    mflo $t8
    sw $t4, array($t8)

    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $t0, 0
    jal arrayPrint

    lw $ra, 0($sp)
    addi $sp, $sp, 4

    addi $t1, $t1, 4
    addi $t2, $t2, 4
    addi $t3, $t3, 4
    j while_loop

for_loop:
    # We use $t5 as the int i
    move $t5, $t2
    ble $t5, $t1, exitLoop

    li $v0, 4
    la $a0, for
    syscall

    addi $t8, $t5, -1
    li $t9, 4
    mult $t8, $t9
    mflo $t9
    lw $t8, array($t9)
    li $t9, 4
    mult $t5, $t9
    mflo $t9
    sw $t8, array($t9)

    addi $sp, $sp, -4
    sw $ra, 0($sp)

    jal arrayPrint

    lw $ra, 0($sp)
    addi $sp, $sp, 4    

    addi $t5, $t5, -1
    j for_loop

less:
    addi $t1, $t1, 1
    j while_loop

exitLoop:
    jr $ra

main:
    # $t0 is the register which stores pointer to last element in array
    li $t0, 0

    # Asking number of elements in array
    li $v0, 5
    syscall
    move $s2, $v0

    li $s1, 4

    mult $s2, $s1
    mflo $s4  # Now s4 stores the value of 4*(Number of elements)


    jal arrayInput

    li $t0, 0
    jal arrayPrint

    li $t0, 0
    li $s0, 0
    addi $s1, $s2, -1  # This may cause errors

    move $s5, $s0
    move $s6, $s1

    jal mergeSort

    li $v0, 4
    la $a0, debugger5
    syscall

    li $t0, 0
    jal arrayPrint

    li $v0, 10
    syscall