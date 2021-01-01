.data
.text
	li $v0, 5
	syscall
	move $a0, $v0
	li $v0, 5
	syscall
	move $a1, $v0
	li $v0, 5
	syscall
	move $a2, $v0
	jal sort
	nop
	j end
	nop
	
sort:
	ble $a0, $a1, case1
	nop
	move $t3, $a0
	move $a0, $a1
	move $a1, $t3
case1:	
	ble $a0, $a2, case2
	nop
	move $t3, $a0
	move $a0, $a2
	move $a2, $t3
case2:	
	ble $a1, $a2, case3
	nop
	move $t3, $a1
	move $a1, $a2
	move $a2, $t3
case3:
	jr $ra
	nop
end: