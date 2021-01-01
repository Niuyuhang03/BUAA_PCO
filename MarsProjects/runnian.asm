.data
	space:.asciiz " "
.text
	li $v0, 5
	syscall
	move $t0, $v0
	
	#400±¶Êý
	li $t1, 400
	divu $t0, $t1
	mfhi $t1
	beq $t1, $zero, if_yes
	nop
	
	#4±¶Êý
	li $t1, 4
	li $t2, 100
	divu $t0, $t1
	mfhi $t1
	divu $t0, $t2
	mfhi $t2
	beq $t1, $zero, if_1_begin
	nop
	
if_no:
	li $a0, 0
	li $v0, 1
	syscall
	
	j if_yes_end
	nop
	
if_1_begin:
	bgtz $t2, if_yes
	nop
	j if_no
	nop
	
if_yes:
	li $a0, 1
	li $v0, 1
	syscall
if_yes_end:
	