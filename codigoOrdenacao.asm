.data
ordem_original: .word 4,3,9,5,2,1   
ordem_arrumada: .space 24            
flags: .space 24                    
tamanho: .word 6                     
space: .asciiz " "                    
head: .asciiz "Lista ordenada:"      

.text
.globl main
main:
    la $t0, ordem_original 
    la $t1, flags          
    la $t2, ordem_arrumada   
    lw $t3, tamanho          
    li $t4, 0              

# loop gigante
loop_principal:
    beq $t4, $t3, imprimir   

    li $t5, 1000        
    li $t6, -1               
    li $t7, 0                


achar_menor:
    bge $t7, $t3, colocar    

    sll $t8, $t7, 2        
    add $t9, $t0, $t8      
    lw $s0, 0($t9)         

    add $t9, $t1, $t8       
    lw $s1, 0($t9)           
    bne $s1, $zero, proximo  

    blt $s0, $t5, novo_menor 
    j proximo                

novo_menor:
    move $t5, $s0            
    move $t6, $t7           

proximo:
    addi $t7, $t7, 1         
    j achar_menor            

#coloca menor valor no vetor ordenado
colocar:
    sll $t8, $t4, 2          
    add $t9, $t2, $t8        
    sw $t5, 0($t9)           

    sll $t8, $t6, 2          
    add $t9, $t1, $t8        
    li $s1, 1                
    sw $s1, 0($t9)

    addi $t4, $t4, 1        
    j loop_principal         
#imprimi resultado
imprimir:
    la $a0, head            
    li $v0, 4               
    syscall

    move $a0, $t2            
    move $a1, $t3
    # Chama função print_array            
    jal print_array         

    li $v0, 10               
    syscall


print_array:
#t0 endereco inicial do array
    add $t0, $zero, $a0      
    add $t1, $zero, $a1    

next_print:

#se tamanho = 0 acaba
    beq $t1, $zero, fim_print 
    lw $a0, 0($t0)           
    li $v0, 1               
    syscall

    la $a0, space            
    li $v0, 4                
    syscall

#avanca para proximo (elemento +4)
    addi $t0, $t0, 4        
    addi $t1, $t1, -1        
    j next_print             

fim_print:
    jr $ra               
