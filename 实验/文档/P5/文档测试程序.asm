.data
.text
#功能测试
	#测试ori指令，第三个立即数是无符号扩展，不存在负数的情况
	ori $a0, $0, 123		#测试与0进行or运算
	ori $a1, $a0, 456		#测试两个非0数的or运算
	ori $0, $0, 123			#测试写入0号寄存器
	#测试lui指令
	lui $a2, 123			#测试，构造正数
	lui $a3, 0xffff			#测试，构造负数
	#测试addu指令，无符号相加，不存在负数情况
	addu $s0, $a0, $a2		#测试正数相加
	#测试subu指令，无符号相减，不存在负数情况
	subu $s1, $a2, $a0		#测试正数相减
	#测试sw指令
	ori $t0, $t0, 0x0000		#构造0
	sw $a0, 0($t0)			#测试存入内存
	sw $a1, 4($t0)			#测试存入内存
	#测试lw指令
	lw $s0, 0($t0)			#测试内存里数写入寄存器
	lw $s1, 4($t0)			#测试内存里数写入寄存器
	#测试beq指令
	ori $a0, $0, 1			#构造1
	ori $a1, $0, 2			#构造2
	ori $a2, $0, 1			#构造1
	beq $a0, $a1, l1		#测试不跳转
	nop
	beq $a0, $a2, l2		#测试跳转
	nop
l1:ori $a0, $0, 0
l2:ori $a1, $0, 0
	#测试jal,jr指令
	ori $s2, $2, 1
	ori $s3, $2, 2
	addu $s4, $s2, $s3
	jal l4
	nop
	jal l5
	nop
	ori $s2, $2, 3
l4:	ori $s3, $2, 4
	jr $ra
l5:	nop
	#测试jalr
	ori $t4, $0, 0x3090
	jalr $t5, $t4
	nop
	ori $t6, $0, 1

l3:	ori $t4, $0, 1

#转发暂停测试
#初始化内存单元
ori $t0,$0,16
sw $t0,0($0)
ori $t0,$0,432
sw $t0,4($0)
ori $t0,$0,858
sw $t0,8($0)
ori $t0,$0,656
sw $t0,12($0)
ori $t0,$0,8419
sw $t0,16($0)
ori $t0,$0,3420
sw $t0,20($0)
ori $t0,$0,29812
sw $t0,24($0)
ori $t0,$0,1812
sw $t0,28($0)
ori $t0,$0,213
sw $t0,32($0)

#addu
#addu RSuse,RTuse在E
ori $t1,$0,516
ori $t2,$0,233
#R-M-RS
subu $t0,$t1,$t2
addu $t3,$t0,$t1
#R-M-RT
subu $t0,$t2,$t1
addu $t3,$t1,$t0
#R-W-RS
subu $t0,$t1,$t2
nop
addu $t3,$t0,$t1
#R-W-RT
subu $t0,$t2,$t1
nop
addu $t3,$t1,$t0
#I-M-RS
ori $t0,$t1,101
addu $t3,$t0,$t1
#I-M-RT
ori $t0,$t1,102
addu $t3,$t1,$t0
#I-W-RS
ori $t0,$t1,103
nop
addu $t3,$t0,$t1
#I-W-RT
ori $t0,$t1,104
nop
addu $t3,$t1,$t0
#LD-M-RS
lw $t0,0($0)
addu $t3,$t0,$t1
#LD-M-RT
lw $t0,4($0)
addu $t3,$t1,$t0
#LD-W-RS
lw $t0,8($t0)
nop
addu $t3,$t0,$t1
#LD-W-RT
lw $t0,12($t0)
nop
addu $t3,$t1,$t0
#JAL-M-RS
jal loop1
addu $t2,$ra,$t0
#JAL-M-RT
jal loop2
addu $t2,$t0,$ra
#JAL-W-RS
jal loop1
nop
addu $t2,$ra,$t0
#JAL-W-RT
jal loop2
nop
addu $t2,$t0,$ra

#ori
#ori RSuse在E
#R-M-RS
addu $t0,$t1,$t2
ori $t1,$t0,233
#R-W-RS
addu $t0,$t1,$t2
nop
ori $t1,$t0,242
#I-M-RS
lui $t0,454
ori $t1,$t0,234
#I-W-RS
lui $t0,49
nop
ori $t1,$t0,34
#LD-M-RS
lw $t0,16($0)
ori $t0,342
#LD-W-RS
lw $t0,20($0)
nop
ori $t0,984
#JAL-M-RS
jal loop1
ori $t0,$ra,5995
#JAL-W-RS
jal loop2
nop
ori $t0,$ra,488

#lw
#lwRSuse在E
ori $t0,$0,0
ori $t1,$0,4
#R-M-RS
addu $t0,$t0,$t1
lw $t3,0($t0)
#R-W-RS
addu $t0,$t0,$t1
nop
lw $t3,0($t0)
#I-M-RS
ori $t0,$0,16
lw $t3,0($t0)
#I-W-RS
ori $t0,$0,20
nop
lw $t3,0($t0)
#LD-M-RS
lw $t0,40($0)
lw $t3,0($t0)
#LD-W-RS
lw $t0,0($0) #t0=4
nop
lw $t3,0($t0)
#SD-M-RS
sw $t3,36($0)
lw $t4,36($0)
#SD-W-RS
sw $t3,40($0)
nop
lw $t4,40($0)

#beq
#beq,RSuse/RTuse在D
#R-E-RS
ori $t0,$0,0
ori $t1,$0,0
ori $t2,$0,1
ori $t3,$0,2
addu $t0,$t0,$t2
beq $t0,$t1,wrong
nop
#R-E-RT
ori $t0,$0,0
addu $t1,$t1,$t3
beq $t0,$t1,wrong
nop
#R-M-RS
ori $t0,$0,0
ori $t1,$0,0
addu $t0,$t0,$t2
nop
beq $t0,$t1,wrong
nop
#R-M-RT
ori $t0,$0,0
addu $t1,$t1,$t3
nop
beq $t0,$t1,wrong
nop
#R-W-RS
ori $t0,$0,0
ori $t1,$0,0
addu $t0,$t0,$t2
nop
nop
beq $t0,$t1,wrong
nop
#R-W-RT
ori $t0,$0,0
addu $t1,$t1,$t3
nop
nop
beq $t0,$t1,wrong
nop
#LD-E-RS
ori $t0,$0,1
ori $t1,$0,1
lw $t0,100($0)
beq $t0,$t1,wrong
nop
#LD-M-RS
ori $t0,$0,1
ori $t1,$0,1
lw $t0,100($0)
nop
beq $t0,$t1,wrong
nop
#LD-W-RS
ori $t0,$0,1
ori $t1,$0,1
lw $t0,100($0)
nop
nop
beq $t0,$t1,wrong
nop
#JAL-E-RS
ori $t0,$0,0
ori $ra,$0,0
jal loop1
beq $t0,$ra,wrong
nop
#JAL-M-RS
ori $ra,$0,0
jal loop4
nop
loop4:beq $t0,$ra,wrong
nop
#JAL-W-RS
ori $ra,$0,0
jal loop5
nop
loop5:nop
beq $t0,$ra,wrong
nop


#sw
#sw,RSuse在E,RTuse在M
#R-M-RS
addu $t0,$0,4
sw $t4,0($t0)
#R-M-RT
addu $t3,$0,423
sw $t3,0($t0)
#R-W-RS
addu $t0,$t0,4
nop
sw $t3,0($t0)
#R-W-RT
addu $t3,$t0,24214
nop
sw $t3,0($t0)
#I-M-RS
ori $t0,$0,16
sw $t3,0($t0)
#I-M-RT
ori $t3,$0,235
sw $t4,0($t0)
#I-W-RS
ori $t0,$0,20
nop
sw $t3,0($t0)
#I-W-RT
ori $t3,$0,9885
nop
sw $t3,0($t0)
#LD-M-RS
lw $t0,64($0)
sw $t3,0($t0)
#LD-M-RT
lw $t0,24($0)
sw $t0,32($0)
#LD-W-RS
lw $t0,80($0)
nop
sw $t3,4($t0)
#LD-W-RT
lw $t3,32($0)
nop
sw $t3,0($0)
#JAL-M-RT
jal loop1
sw $ra,0($0)
#JAL-W-RT
jal loop3
nop
loop3:
sw $ra,0($0)


j end
nop

wrong:

loop1:
jr $ra
nop
nop

loop2:
jr $ra
nop
nop
end:

