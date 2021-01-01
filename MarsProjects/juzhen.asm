.data
	space:.asciiz " "
	enter:.asciiz "\n"
	arr:.space 5000
.text
	#$s0 a,$s1 b,$s2 n
	li $v0, 5
	syscall
	move $s0, $v0
	li $v0, 5
	syscall
	move $s1, $v0
	
	mult $s0, $s1
	mflo $s2
	
	#$t0 i,$t1 input,$t2 hang,$t3 lie,$s3 arr pointer
	la $s3, arr
	li $t0, 1
	li $t2, 1
	li $t3, 1
for_1_begin:
	sub $t4, $t0, 1
	beq $t4, $s2, for_1_end
	nop
	li $v0, 5
	syscall
	move $t1, $v0
	beq $t1, $zero, addself
	
	sw $t2, 0($s3)
	addi $s3, $s3, 4
	sw $t3, 0($s3)
	addi $s3, $s3, 4
	sw $t1, 0($s3)
	addi $s3, $s3, 4
	
addself:addi $t0, $t0, 1
	addi $t3, $t3, 1
	sub $t4, $t3, $s1
	bgtz $t4, if_greater_begin
	nop
	
if_greater_end:
	j for_1_begin
	nop
	
if_greater_begin:
	li $t3, 1
	addi $t2, $t2, 1
	j if_greater_end
	nop

for_1_end:
	la $t3, arr
	subi $s3, $s3, 4
out:
	addi $t0, $s3, 4
	beq $t0, $t3, out_end
	nop
	
	lw $t2, 0($s3)
	subi $s3, $s3, 4
	lw $t1, 0($s3)
	subi $s3, $s3, 4
	lw $t0, 0($s3)
	subi $s3, $s3, 4
	
	move $a0,$t0
	li $v0, 1
	syscall
	la $a0, space
	li $v0, 4
	syscall
	
	move $a0, $t1
	li $v0, 1
	syscall
	la $a0, space
	li $v0, 4
	syscall
	
	move $a0, $t2
	li $v0, 1
	syscall
	la $a0, enter
	li $v0, 4
	syscall
	
	j out
	nop
out_end: