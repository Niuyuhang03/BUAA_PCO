.data
	example100:.space 400
.text
	la $t0, example100
	li $s0, 0		#$s0, answer
	li $t2, 0		#$t2, counter
for1_begin:
	lw $t1, 0($t0)
	add $s0, $s0, $t1
	
	addi $t1, $t1, 4
	addi $t2, $t2, 1
	beq $t2, 100, end
	nop
	j for1_begin
	nop
	
end:
	sw $s0, 0($t1)