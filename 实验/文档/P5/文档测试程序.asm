.data
.text
#���ܲ���
	#����oriָ����������������޷�����չ�������ڸ��������
	ori $a0, $0, 123		#������0����or����
	ori $a1, $a0, 456		#����������0����or����
	ori $0, $0, 123			#����д��0�żĴ���
	#����luiָ��
	lui $a2, 123			#���ԣ���������
	lui $a3, 0xffff			#���ԣ����츺��
	#����adduָ��޷�����ӣ������ڸ������
	addu $s0, $a0, $a2		#�����������
	#����subuָ��޷�������������ڸ������
	subu $s1, $a2, $a0		#�����������
	#����swָ��
	ori $t0, $t0, 0x0000		#����0
	sw $a0, 0($t0)			#���Դ����ڴ�
	sw $a1, 4($t0)			#���Դ����ڴ�
	#����lwָ��
	lw $s0, 0($t0)			#�����ڴ�����д��Ĵ���
	lw $s1, 4($t0)			#�����ڴ�����д��Ĵ���
	#����beqָ��
	ori $a0, $0, 1			#����1
	ori $a1, $0, 2			#����2
	ori $a2, $0, 1			#����1
	beq $a0, $a1, l1		#���Բ���ת
	nop
	beq $a0, $a2, l2		#������ת
	nop
l1:ori $a0, $0, 0
l2:ori $a1, $0, 0
	#����jal,jrָ��
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
	#����jalr
	ori $t4, $0, 0x3090
	jalr $t5, $t4
	nop
	ori $t6, $0, 1

l3:	ori $t4, $0, 1

#ת����ͣ����
#��ʼ���ڴ浥Ԫ
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
#addu RSuse,RTuse��E
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
#ori RSuse��E
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
#lwRSuse��E
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
#beq,RSuse/RTuse��D
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
#sw,RSuse��E,RTuse��M
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

