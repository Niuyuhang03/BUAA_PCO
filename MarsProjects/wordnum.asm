.data
	ch:.space 200
	num:.space 200
	space:.asciiz" "
	enter:.asciiz"\n"
.text
	li $t0, 0			#$t0, i
	li $t1, 0			#$t1, diffnum
	li $v0, 5
	syscall
	move $s0, $v0			#$s0, n
	
for1_begin:
	li $v0, 12
	syscall
	move $t2, $v0			#$t2, chara
	bnez $t0, if1_else
	nop
if1_begin:
	la $s1, ch
	la $s2, num
	li $t3, 1
	sw $t2, 0($s1)
	sw $t3, 0($s2)
	addi $t1, $t1, 1
	j if1_end
	nop
if1_else:
	li $t5, 0			#$t5, counter
for2_begin:
	la $s1, ch
	li $t3, 4
	mult $t3, $t5
	mflo $t3
	add $s1, $s1, $t3
	lw $t3, 0($s1)
	bne $t2, $t3, if2_end
	nop
if2_begin:
	la $s2, num
	li $t3, 4
	mult $t3, $t5
	mflo $t3
	add $s2, $s2, $t3
	lw $t3, 0($s2)
	addi $t3, $t3, 1
	sw $t3, 0($s2)
	j if3_end
	nop
if2_end:
	addi $t5, $t5, 1
	bne $t5, $t1, for2_begin
	nop
if3_begin:
	la $s1, ch
	li $t3, 4
	mult $t3, $t5
	mflo $t3
	add $s1, $s1, $t3
	sw $t2, 0($s1)
	la $s2, num
	li $t3, 4
	mult $t3, $t5
	mflo $t3
	add $s2, $s2, $t3
	li $t3, 1
	sw $t3, 0($s2)
	addi $t1, $t1, 1
if3_end:
if1_end:	
	addi $t0, $t0, 1
	bne $t0, $s0, for1_begin
	nop
	
	li $t0, 0			#$t0, i
	li $t2, 4
for4_begin:
	la $s1, ch
	la $s2, num
	mult $t0, $t2
	mflo $t3
	add $s1, $s1, $t3
	add $s2, $s2, $t3
	lw $t4, 0($s1)
	lw $t5, 0($s2)
	move $a0, $t4
	li $v0, 11
	syscall
	la $a0, space
	li $v0, 4
	syscall
	move $a0, $t5
	li $v0, 1
	syscall
	la $a0, enter
	li $v0, 4
	syscall
	
	addi $t0, $t0, 1
	bne $t0, $t1, for4_begin
	nop