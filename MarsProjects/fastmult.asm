.data
	c:.space 400
	res:.space 400
	space:.asciiz" "
	enter:.asciiz"\n"
.text
	li $v0, 5
	syscall
	move $s0, $v0			#$s0, n
	mult $s0, $s0
	mflo $s1			#$s1, n*n
	li $t2, 1
	li $t0, 0
	la $s2, c
	la $s3, res
for1_begin:
	li $v0, 5
	syscall
	move $t1, $v0
	sw $t1, 0($s2)
	sw $t2, 0($s3)
	addi $t0, $t0, 1
	addi $s2, $s2, 4
	addi $s3, $s3, 4
	bne $t0, $s1, for1_begin
	nop

	li $t0, 0			#$t0, i
	li $v0, 5
	syscall
	move $s2, $v0			#$s2, m
for2_begin:
	li $t1, 2
	div $s2, $t1
	mfhi $t1
	beqz $t1, if1_end
	nop
if1_begin:
	la $a0, res
	la $a1, res
	la $a2, c
	jr pow
	nop
if1_end:
	la $a0, c
	la $a1, c
	la $a0, c
	jr pow
	nop
	li $t1, 2
	div $s2, $t1
	mflo $s2
	bnez $s2, for2_begin
	nop
	
pow:
	
	jal $ra
	nop