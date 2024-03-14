.data

inputstring: .asciiz "Enter the number(n): "
outputstring: .asciiz "The factorial of "
outputstring1: .asciiz " is "
newline: .asciiz "\n"
recursing: .asciiz "Recursing with input = "
a1value: .asciiz "$a1 = "
v1value: .asciiz "$v1 = "

.text
.globl main
.globl computeFactorial

computeFactorial:
    # First create space by shifting the stack pointer
    addi $sp, $sp, -8
    sw $ra 0($sp)
    sw $a1 4($sp)

    # Base case: if n == 1 return 1
    beq $a1, 1, factorialDone

    sub $a1, $a1, 1
    jal computeFactorial

    lw $ra, 0($sp)
    lw $a1, 4($sp)

    mul $v1, $v1, $a1

    addi $sp, $sp, 8
    jr $ra

factorialDone:
    li $v1, 1
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
    jal computeFactorial

    # Printing the result
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
    move $a0, $v1
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 10
    syscall