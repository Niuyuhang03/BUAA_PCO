.data
	space:.asciiz" "
	enter:.asciiz"\n"
	arr1:.space 400
	arr2:.space 400

.text
	li $v0, 5
	syscall
	move $s0, $v0	#$s0为n
	mult $s0, $s0
	mflo $s1	#$s1为n^2
	
	li $t1, 0
	la $t0, arr1
for1_begin:
	li $v0, 5
	syscall
	sw $v0, 0($t0)
	addi $t0, $t0, 4
	addi $t1, $t1, 1
	bne $t1, $s1, for1_begin
	nop

	li $t1, 0
	la $t0, arr2
for2_begin:
	li $v0, 5
	syscall	
	sw $v0, 0($t0)
	addi $t0, $t0, 4
	addi $t1, $t1, 1
	bne $t1, $s1, for2_begin
	nop

	li $t3, 0	#num of 行
	li $t4, 0	#num of 列
for3_begin:
	li $s2, 0		#$s0为答案矩阵某个值
	la $t1, arr1
	la $t2, arr2
	mult $t3, $s0
	mflo $t5
	li $t0, 4
	mult $t5, $t0
	mflo $t5
	add $t5, $t1, $t5	#$t5为计算某值arr1起始位置
	mult $t4, $t0
	mflo $t6
	add $t6, $t2, $t6	#$t6为计算某值arr2起始位置
	li $t0, 0		#求$t5时第0-n个元素相加，此时为第$t0个
for4_begin:
	lw $s4, 0($t5)
	lw $s5, 0($t6)
	mult $s4, $s5
	mflo $s3
	add $s2, $s2, $s3

	addi $t5, $t5, 4
	li $t7, 4
	mult $s0, $t7
	mflo $t7
	add $t6, $t6, $t7
	addi $t0, $t0, 1
	bne $s0, $t0, for4_begin
	nop
	
	move $a0, $s2
	li $v0, 1
	syscall
	
	addi $t4, $t4, 1
if_begin:
	bne $t4, $s0, if_end
	nop
	addi $t3, $t3, 1
	li $t4, 0
	
	la $a0, enter
	li $v0, 4
	syscall
	j restart
	nop
if_end:
	la $a0, space
	li $v0, 4
	syscall
restart:
	bne $t3, $s0, for3_begin
	nop