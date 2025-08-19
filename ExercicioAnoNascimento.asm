.data
 prompt : .asciiz "Digite seu ano de nascimento "
 message : .asciiz "\n Soma do ano + 2025:  "
 num2: .word 2025
.text 
main:
li $v0, 4 #4= system code for printing a string, 
lw $t1, num2
la $a0,prompt # load address of prompt in $a0
syscall # prints the string � Enter your age�


# pega o input do usuario
li $v0,5 #5= system code for user input
syscall #Call to the System to execute the instruction
move $t0, $v0 # Store the result in $t0

add $t2, $t0, $t1

# Display the user input
li $v0, 4 #4= system code for printing a string, 

la $a0, message # load address of prompt in $a0
syscall # prints the string � Your age is�
# Show the age
li $v0, 1 #1= system code for printing a word, 
move $a0, $t2 # move is a pseudo-instruction that transfers contents of $t0 to $a0
#a0 is the register that needs to hold the value that needs to be printed
syscall #Call to the System to execute our instructions 

li $v0, 10
syscall