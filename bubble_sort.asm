# Computer Architecture 
#
# Pagkalos Spyros p3150133
# Gkoumas Christos p3160026
#
# MIPS Bubble Sort

.data
sample: .word 15, 1, 10, 6, 2, 11, 16, 14, 13, 19, 20, 8, 17, 9, 4, 12, 3, 7, 5, 18

.text
.globl main

main:
la $a0, sample # Loading SAMPLE data
li $s0, -1 # i

first_loop:
addi $s0, $s0, 1
li $t0, 20 # Load 20 to compare to
bge $s0, $t0 end
li $s1, -1 # j

second_loop:
addi $s1, $s1, 1
li $t0, 20 # Load 20 to compare to
sub $t0, $t0, $s0 # Reduce by $s0=i
bge $s1, $t0, first_loop

# Check starts

move $t0, $a0 # Pointer for n1
move $t1, $a0 # Pointer for n2

move $t2, $s1 # Create first actual pointer
add $t2, $t2, $t2
add $t2, $t2, $t2 # Multiply position by 4
add $t0, $t0, $t2

move $t3, $s1 # Create second actual pointer
addi $t3, $t3, 1 # j + 1
add $t3, $t3, $t3
add $t3, $t3, $t3 # Multiply position by 4
add $t1, $t1, $t3

# Check pointers ready

lw $s2, 0($t0)
lw $s3, 0($t1)
blt $s2, $s3, second_loop

sw $s3, 0($t0) # Do the swap
sw $s2, 0($t1)
j second_loop

end:
li $v0, 10
syscall
