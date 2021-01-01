.data
.text
	li $v0, 5
	syscall
	move $s0, $v0
	li $v0, 5
	syscall
	move $s1, $v0

	move $a0, $s0
	jal ABS
	nop

	move $a0, $s1
	jal ABS
	nop
	
	j end
	nop

ABS:
if_begin:
	bgtz $a0, if_end
	nop
	li $t0, 0
	sub $a0, $t0, $a0
if_end:
	jr $ra
	nop
end: