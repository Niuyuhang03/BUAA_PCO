.data
	array:.space 400
.text
	la $a1, array
	li $v0, 5
	syscall
	move $a0, $v0
	jal FIB
	nop
	j end
	nop
	
FIB:
	move $s0, $a0		#s0, n
	move $t0, $a1		#$t0, arr
	li $t1, 1
	sw $t1, 0($t0)
	beq $s0, 1, back
	nop
	addi $t0, $t0, 4
	sw $t1, 0($t0)
	beq $s0, 2, back
	nop
	addi $t0, $t0, 4
	move $t2, $t1		#$t1, arr[i-1]	$t2, arr[i-2]
	li $s1, 2		#s1, i
for_begin:
	add $t3, $t1, $t2
	sw $t3, 0($t0)
	addi $s1, $s1, 1
	addi $t0, $t0, 4
	move $t2, $t1
	move $t1, $t3
	bne $s1, $s0, for_begin
	nop
	
back:	jr $ra
	nop
end: