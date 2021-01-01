.data
	arr:.space 800
	space:.asciiz" "
.text
	li $v0, 5
	syscall
	move $s0, $v0		#$s0, n
	
	li $t0, 0
	la $t1, arr
for1_begin:
	li $v0, 5
	syscall
	sw $v0, 0($t1)
	addi $t1, $t1, 4
	addi $t0, $t0, 1
	bne $t0, $s0, for1_begin
	nop

	li $t0, 0		#t0, current in for2 * 4
	li $t1, 0		#$t1, flag
	li $t2, 4		#costanst 4
	move $s3, $s0
for2_begin:
	la $t3, arr
	li $t5, 1		#$t5, current in for3
	li $t1, 0
for3_begin:
	add $t4, $t3, $t2
if_begin:
	lw $s1, 0($t3)
	lw $s2, 0($t4)
	ble $s1, $s2, swap_end
	nop
	
	li $t1, 1
	sw $s1, 0($t4)
	sw $s2, 0($t3)
swap_end:
	addi $t5, $t5, 1
	add $t3, $t3, $t2
	bne $t5, $s3, for3_begin
	nop
	
	subi $s3, $s3, 1
	beqz $t1, out
	nop
	beq $s3, 1, out
	nop
	addi $t0, $t0, 1
	j for2_begin
	nop
out:
	li $t1, 0
out_start:
	la $t0, arr
	mult $t1, $t2
	mflo $t3
	add $t0, $t0, $t3
	lw $a0, 0($t0)
	li $v0, 1
	syscall
	la $a0, space
	li $v0, 4
	syscall
	addi $t1, $t1, 1
	bne $t1, $s0, out_start
	nop
