.data
	SRC:.space 400
	DEST:.space 400
.text
	li $t0, 0		#$t0, counter
	la $t1, SRC
	la $t2, DEST
for_begin:
	lw $t3, 0($t1)
	sw $t3, 0($t2)
	addi $t1, $t1, 4
	addi $t2, $t2, 4
	addi $t0, $t0, 1
	bne $t0, 100, for_begin
	nop