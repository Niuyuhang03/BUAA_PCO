.data
	arr1:.space 80
	arr2:.space 80
	space:.asciiz" "
.text
	li $v0, 5
	syscall
	move $s0, $v0		#$s0, n
	
	la $s1, arr1
	la $s2, arr2
	li $t0, 4
	mult $s0, $t0
	mflo $t0
	add $s2, $s2, $t0
	subi $s2, $s2, 4
	li $t0, 0		#$t0, i
for1_begin:
	li $v0, 12
	syscall
	move $t1, $v0
	sw $t1, 0($s1)
	sw $t1, 0($s2)
	addi $t0, $t0, 1
	beq $t0, $s0, for1_end
	nop
	
	addi $s1, $s1, 4
	subi $s2, $s2, 4
	j for1_begin
	nop
for1_end:
	la $s1, arr1
	la $s2, arr2
	li $t0, 0
for2_begin:
	lw $t1, 0($s1)
	lw $t2, 0($s2)
	bne $t1, $t2, out0
	nop
	addi $t0, $t0, 1
	beq $t0, $s0, out1
	nop
	addi $s1, $s1, 4
	addi $s2, $s2, 4
	j for2_begin
	nop
out0:
	li $a0, 0
	li $v0, 1
	syscall
	j out1_end
	nop
out1:
	li $a0, 1
	li $v0, 1
	syscall
out1_end: