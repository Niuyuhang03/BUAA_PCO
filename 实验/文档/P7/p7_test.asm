.text
	ori $29,0x2ffc
	ori $28,0x1800
	ori $2,0xfc01
	mtc0 $2,$12
	mfc0 $3,$12
	li $7,-2147483648
	subi $7,$7,1
	lui $4,0x7fff
	lui $5,0x7fff
	add $6,$4,$5
	nop
	lw $9,2($0)
	lui $8,1
	lui $10,0x6666
	ori $10,0x6666
	lw $9,0($10)
	lui $8,2
	lh $9,0($10)
	lui $8,3
	lh $9,3($0)
	lui $8,4
	lb $9,0($10)
	sw $8,0($10)
	lui $8,5
	sh $8,0($10)
	lui $8,6
	sb $8,0($10)
	lui $8,7
	sw $8,2($0)
	lui $8,8
	sh $8,3($0)
	lui $8,9
	