.data
prompt: .asciiz "Which Fibonacci number do you want? "
output: .asciiz "The Fibonacci number is "
error: .asciiz "You must enter an integer greater than or equal to 0. Try again. "
.text
main:
la $a0, prompt
la $a1, error
j readNonNegInt
# prompts the user to enter and integer, then reads int that int
readInt:
li $v0, 4
syscall
li $v0, 5
syscall
jr $ra
# calls read int the if the entered int is negative it calls the error, if not calls the Fibonacci method
readNonNegInt:
jal readInt
bltz $v0, printError
move $a0, $v0
jal fib
j printAnswer
# Changes the address of the register to print to the error prompt
printError:
move $a0, $a1 # sets $a0 with the address of the error prompt so when readInt is called again it gives the error prompt
j readInt
# prints the nth number of the fib sequence
printAnswer:
move $t0, $v0
la $a0, output
li $v0, 4
syscall
move $a0, $t0
li $v0, 1
syscall
j end
#sub-routine for Fibonacci sequence
fib:
bgt $a0, 1, rec # base case returns 0 or 1
move $v0, $a0
jr $ra
rec:
sub $sp, $sp, 12
sw $ra, 0($sp)
sw $a0, 4($sp)
add $a0, $a0, -1
jal fib
lw $a0, 4($sp)
sw $v0, 8($sp)
add $a0,$a0, -2
jal fib
lw $t0, 8($sp)
add $v0, $v0, $t0
lw $ra, 0($sp)
add $sp, $sp, 12
jr $ra
#exit program
end:
li $v0, 10
syscall
