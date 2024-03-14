.data

array: .space 40000
debugger: .asciiz "check"
debugger2: .asciiz "check2"
debugger3: .asciiz "check3"
debugger4: .asciiz "check4"
debugger5: .asciiz "check5"
space: .asciiz " "

# li $v0, 4
# la $a0, debugger
# syscall
newline: .asciiz "\n"

.text
.globl main
.globl exitLoop

arrayInput:
    beq $t0, $t1, exitLoop
    li $v0, 5
    syscall

    move $s0, $v0
    sw $s0, array($t0)

    addi $t0, $t0, 4
    j arrayInput

query:
    beq $t0, $t3, exitLoop
    li $v0, 5
    syscall

    move $s3, $v0  # s3 stores the input query 
                   # s4 stores the output for a query
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $t4, 0  # t4 => l
    addi $t5, $t2, -1  # t5 => r
    jal binarySearch

    lw $ra, 0($sp)
    addi $sp, $sp, 4

    li $v0, 1
    move $a0, $s4
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    addi $t0, $t0, 1
    j query

binarySearch:
    bgt $t4, $t5, null
    sub $t8, $t5, $t4
    li $t9, 2
    div $t8, $t9
    mflo $t8
    add $t8, $t8, $t4   # t8 => m
    
    li $t9, 4
    mult $t8, $t9
    mflo $t9

    lw $t9, array($t9)
    beq $t9, $s3, found_mid
    ble $t9, $s3, lesser
    j else

else:
    addi $t5, $t8, -1
    j binarySearch

lesser:
    addi $t4, $t8, 1
    j binarySearch

found_mid:
    move $s4, $t8
    jr $ra

null:
    li $s4, -1
    jr $ra

arrayPrint:
    beq $t0, $t1, exitPrint
    
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

bubbleSort:
    beq $t3, $t2, exitLoop
    sub $t4, $t2, $t3
    li $t8, 4
    mult $t4, $t8
    mflo $t4 
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    add $t0, $zero, $zero
    jal bubbleLoop
    lw $ra, 0($sp)
    addi $t3, $t3, 1
    j bubbleSort

bubbleLoop:
    beq $t0, $t4, exitLoop
    lw $s0, array($t0)
    addi $t0, $t0, 4
    lw $s1, array($t0)
    slt $t5, $s0, $s1
    beq $t5, 1, bubbleLoop
    lw $s2, array($t0)
    addi $s3, $t0, -4
    lw $s4, array($s3)
    sw $s4, array($t0)
    sw $s2, array($s3)
    j bubbleLoop

exitLoop:
    jr $ra

main:
    # $t0 is the register which stores pointer to last element in array
    add $t0, $zero, $zero

    # Asking number of elements in array
    li $v0, 5
    syscall
    move $t2, $v0

    li $t1, 4

    mult $t2, $t1
    mflo $t1  # Now t1 stores the value of 4*(Number of elements)

    jal arrayInput

    add $t0, $zero, $zero
    addi $t3, $zero, 1

    jal bubbleSort

    li $t0, 0
    jal arrayPrint

    # Asking number of queries
    li $v0, 5
    syscall
    move $t3, $v0

    li $t0, 0
    jal query

    li $v0, 10
    syscall