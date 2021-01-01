.data
	judge:.space 40
	arr:.space 800
.text
	# $s0 n, $s1, m, $s2 step, $t0 i
	li $v0, 5
	syscall
	move $s0, $v0
	li $v0, 5
	syscall
	move $s1, $v0
	
	li $s2, 1
	la $t2, judge
	li $t1, 1
	sw $t1, 0($t2)
	li $t0, 0
for_1_begin:
	beq $t0, $s1, for_1_end
	nop
	
	li $v0, 5
	syscall
	move $t1, $v0
	li $v0, 5
	syscall
	move $t2, $v0
	
	la $t3, arr
	subi $t4, $t1, 1
	subi $t5, $t2, 1
	mult $t4, $s0
	mflo $t6
	mult $t5, $s0
	mflo $t7
	add $t5, $t5, $t6
	li $t6, 4
	mult $t5, $t6
	mflo $t5
	add $t3, $t3, $t5
	li $t5, 1
	sw $t5, 0($t3)
	la $t3, arr
	add $t4, $t4, $t7
	mult $t4, $t6
	mflo $t4
	add $t3, $t3, $t4
	sw $t5, 0($t3)
	
	addi $t0, $t0, 1
	j for_1_begin
	nop
for_1_end:

	# $s0 n, $s1 m, $s2 step
	li $a0, 0
	li $a1, 1
	jal hamiltonian
	nop
	
	beq $s2, $s0, out_1_begin
	nop
	li $a0, 0
	li $v0, 1
	syscall
	j out_1_end
	nop

hamiltonian:
	# $t0 i, $t1 cur
	move $t0, $a0
	move $t1, $a1
	sw $ra, 0($sp)
	subi $sp, $sp, 4
	sw $t1, 0($sp)
	subi $sp, $sp, 4
	sw $t0, 0($sp)
	subi $sp, $sp, 4
	li $t0, 0
for_2_begin:
	beq $s2, $s0, out_1_begin
	beq $t0, $s0, for_2_end
	nop
	
	subi $t4, $t1, 1
	mult $t4, $s0
	mflo $t4
	add $t4, $t4, $t0
	li $t2, 4
	mult $t4, $t2
	mflo $t4
	la $t2, arr
	add $t2, $t2, $t4
	lw $t4, 0($t2)
	bne $t4, 1, if_end
	nop
	
	la $t4, judge
	li $t2, 4
	mult $t0, $t2
	mflo $t2
	add $t2, $t2, $t4
	lw $t4, 0($t2)
	bne $t4, 0, if_end
	nop
	
	addi $s2, $s2, 1
	li $t3, 1
	sw $t3, 0($t2)
	add $t3, $t0, 1
	move $a0, $t0
	move $a1, $t3
	jal hamiltonian
	nop
	
if_end:
	addi $t0, $t0, 1
	j for_2_begin
	nop
for_2_end:
	addi $sp, $sp, 4
	lw $t0, 0($sp)
	addi $sp, $sp, 4
	lw $t1, 0($sp)
	addi $sp, $sp, 4
	lw $ra, 0($sp)
	jr $ra
	nop
	
out_1_begin:
	li $a0, 1
	li $v0, 1
	syscall
out_1_end: