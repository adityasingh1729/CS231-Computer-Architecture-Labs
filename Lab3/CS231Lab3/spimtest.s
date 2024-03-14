.data

inputstring:   .asciiz "Enter the number(n): "
outputstring:  .asciiz "The factorial of "
outputstring1: .asciiz " is "
newline:  .asciiz "\n"

.text
.globl main

loop:
    beq $a0, 0, loopdone
    mul $s0, $s0, $a0
    sub $a0, $a0, 1
    j loop

loopdone:
    jr $ra

main:
    # Printing "Enter the number: "
    li $v0, 4
    la $a0, inputstring
    syscall

    # Taking the input
    li $v0, 5
    syscall

    move $a0, $v0
    move $a1, $v0

    # Calculating the factorial
    li $s0, 1
    jal loop

    li $v0, 4
    la $a0, outputstring
    syscall

    li $v0, 1
    move $a0, $a1
    syscall

    li $v0, 4
    la $a0, outputstring1
    syscall

    li $v0, 1
    move $a0, $s0
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 10
    syscall