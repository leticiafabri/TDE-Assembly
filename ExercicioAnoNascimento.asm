.data
 prompt : .asciiz "Digite seu ano de nascimento "
 message : .asciiz "\n Soma do ano + 2025:  "
 num2: .word 2025
.text 
main:
li $v0, 4 #4= system code for printing a string, 
lw $t1, num2
la $a0,prompt
syscall 


# pega o input do usuario
li $v0,5 #5= system code for user input
syscall #Call to the System to execute the instruction
move $t0, $v0 

add $t2, $t0, $t1

# Display the user input
li $v0, 4 

la $a0, message 
syscall
# Show the age
li $v0, 1 #1= system code for printing a word, 
move $a0, $t2 # transfere valor do t2 para o a0
#a0 tem o valor que vai ser printado
syscall #Chama o sistema para executar

li $v0, 10
syscall
