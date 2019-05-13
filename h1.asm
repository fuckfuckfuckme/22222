.data
array : .word 300
prompt: .asciiz "\nEnter number of element (between 1 and 50) in the array : "
prompt1: .asciiz "\nEnter "
prompt4: .asciiz "\nFound "
prompt5: .asciiz "\nNot Found "
prompt2: .asciiz " positive integers \n"
prompt3: .asciiz "\nEnter a positive integer or -1 to quit : "
.text
la $s0,array

li $v0,4
la $a0,prompt #it will print prompt
syscall
li $v0,5
syscall #ask user input

move $s1,$v0 #size of array

li $v0,4
la $a0,prompt1
syscall
li $v0,1
move $a0,$s1
syscall
li $v0,4
la $a0,prompt2
syscall

li $t0,0
loop:
li $v0,5
syscall
mul $t1,$t0,4
add $t1,$t1,$s0
sw $v0,($t1)

add $t0,$t0,1
blt $t0,$s1,loop


loopForever:

li $v0,4
la $a0,prompt3 #it will print prompt
syscall
li $v0,5
syscall #ask user input
move $s2,$v0 #search number
li $t0,0
searchLoop:
mul $t1,$t0,4
add $t1,$t1,$s0
lw $s3,($t1)

bltz $s2,exit
beq $s3,$s2,found

add $t0,$t0,1
blt $t0,$s1,searchLoop

li $v0,4
la $a0,prompt5 #it will print prompt
syscall

j loopForever

found:
li $v0,4
la $a0,prompt4 #it will print prompt
syscall

j loopForever

exit:

