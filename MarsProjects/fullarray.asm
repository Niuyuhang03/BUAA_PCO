.data
	arr:.space 40
	flag:.space 40
	space:.asciiz" "
	enter:.asciiz"\n"
.text
	li $v0, 5
	syscall
	move $s0, $v0		#$s0, n
	li $a0, 0
	li $t0, 0
	jal fullarray
	nop
	j end
	nop
	
fullarray:
	sw $ra, 0($sp)
	subi $sp, $sp, 4
	sw $t0, 0($sp)
	subi $sp, $sp, 4
	sw $t1, 0($sp)
	subi $sp, $sp, 4
	move $t0, $a0		#$t0, index
	li $t1, 0		#$t1, i in for2
if1_begin:
	blt $t0, $s0, for2_begin
	nop
	la $s1, arr		#$s1, arr
for1_begin:
	lw $a0, 0($s1)
	li $v0, 1
	syscall
	
	addi $s1, $s1, 4
	addi $t1, $t1, 1
	
	beq $t1, $s0, spaceprint_end
	nop	
	la $a0, space
	li $v0, 4
	syscall
spaceprint_end:	
	blt $t1, $s0, for1_begin
	nop
	la $a0, enter
	li $v0, 4
	syscall
	addi $sp, $sp, 4
	lw $t1, 0($sp)
	addi $sp, $sp, 4
	lw $t0, 0($sp)
	addi $sp, $sp, 4
	lw $ra, 0($sp)
	jr $ra
	nop
	
	li $t1, 0		#$t1, i
for2_begin:
if2_begin:
	la $s2, flag
	li $t2, 4
	mult $t1, $t2
	mflo $t2
	add $s2, $s2, $t2		#$s2, address of flag[i]
	lw $t2, 0($s2)
	bnez $t2, if2_end
	nop
	
	la $s1, arr
	li $t3, 4
	mult $t0, $t3
	mflo $t3
	add $s1, $s1, $t3
	addi $t4, $t1, 1		#$t4, i+1
	sw $t4, 0($s1)
	li $t2, 1
	sw $t2, 0($s2)
	addi $t2, $t0, 1
	move $a0, $t2
	jal fullarray
	nop
	
	la $s2, flag
	li $t2, 4
	mult $t1, $t2
	mflo $t2
	add $s2, $s2, $t2
	li $t2, 0
	sw $t2, 0($s2)
if2_end:
	addi $t1, $t1, 1
	blt $t1, $s0, for2_begin
	nop
	addi $sp, $sp, 4
	lw $t1, 0($sp)
	addi $sp, $sp, 4
	lw $t0, 0($sp)
	addi $sp, $sp, 4
	lw $ra, 0($sp)
	jr $ra
	nop
end: