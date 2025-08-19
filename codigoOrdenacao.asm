.data
ordem_original: .word 4,3,9,5,2,1     # lista original
ordem_arrumada: .space 24             # espaço para lista ordenada (6 elementos)
flags: .space 24                      # flags para marcar elementos já escolhidos
tamanho: .word 6
space: .asciiz " "
head: .asciiz "Lista ordenada:"

.text
.globl main
main:
    la $t0, ordem_original   # ponteiro para lista original
    la $t1, flags            # ponteiro para flags
    la $t2, ordem_arrumada   # ponteiro para lista ordenada
    lw $t3, tamanho                # tamanho da lista
    li $t4, 0                # contador de elementos adicionados

loop_principal:
    beq $t4, $t3, imprimir  # se já adicionamos todos, vai imprimir

    li $t5, 1000             # menor temporário
    li $t6, -1               # índice do menor
    li $t7, 0                # índice atual

achar_menor:
    bge $t7, $t3, colocar   # se percorreu toda lista, vai colocar

    sll $t8, $t7, 2
    add $t9, $t0, $t8
    lw $s0, 0($t9)           # valor atual da lista

    add $t9, $t1, $t8
    lw $s1, 0($t9)           # flag atual
    bne $s1, $zero, proximo  # se já escolhido, pula

    blt $s0, $t5, novo_menor
    j proximo

novo_menor:
    move $t5, $s0
    move $t6, $t7

proximo:
    addi $t7, $t7, 1
    j achar_menor

colocar:
    # coloca menor na lista ordenada
    sll $t8, $t4, 2
    add $t9, $t2, $t8
    sw $t5, 0($t9)

    # marca como escolhido
    sll $t8, $t6, 2
    add $t9, $t1, $t8
    li $s1, 1
    sw $s1, 0($t9)

    addi $t4, $t4, 1
    j loop_principal

imprimir:
    la $a0, head
    li $v0, 4
    syscall

    move $a0, $t2
    move $a1, $t3
    jal print_array

    li $v0, 10
    syscall

# rotina para imprimir array de inteiros
print_array:
    add $t0, $zero, $a0    # endereço inicial do array
    add $t1, $zero, $a1    # tamanho do array

next_print:
    beq $t1, $zero, fim_print
    lw $a0, 0($t0)
    li $v0, 1
    syscall

    la $a0, space
    li $v0, 4
    syscall

    addi $t0, $t0, 4
    addi $t1, $t1, -1
    j next_print

fim_print:
    jr $ra
