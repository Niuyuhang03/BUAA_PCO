.data
	s1:.asciiz "$t1 is greater than $t2.\n"
	s2:.asciiz "$t1 is not greater than $t2.\n"
.text
	li $t1, 100
	li $t2, 20
	
	slt $t3, $t2, $t1
	beq $t3, $zero, if_t1_notgreater
	nop
	
	la $a0, s1
	li $v0, 4
	syscall
	j if_t1_notgreater_end
	nop
	
	if_t1_notgreater:
		la $a0, s2
		li $v0, 4
		syscall
		
	if_t1_notgreater_end: