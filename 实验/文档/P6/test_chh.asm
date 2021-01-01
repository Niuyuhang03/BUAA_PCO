#共支持50条指令
#Add,Addu,Sub,Subu,And,Or,Xor,Nor;
#Mult,Multu,Div,Divu,Mfhi,Mflo,Mthi,Mtlo,Madd;
#Sll,Srl,Sra,Sllv,Srlv,Srav;
#Slt,Sltu;
#Jr,Jalr;
#Addi,Addiu,Andi,Ori,Xori,Lui;
#Slti,Sltiu;
#wire Lw,Lb,Lbu,Lh,Lhu,Sw,Sb,Sh;
#wire Beq,Bne,Blez,Bgtz;
#wire Bgezal,Bltz,Bgez;
#wire J,Jal;
#功能测试
ori $t0,$0,520
ori $t1,$t0,233

lui $t0,520
lui $t1,0xffff
ori $t1,$t1,0xffff

#addu,subu
addu $t2,$t0,$t0#++
addu $t3,$t0,$t1#+-
addu $t4,$t1,$t1#--
subu $t5,$t0,$t2#++
subu $t6,$t0,$t1#+-
subu $t7,$t1,$t4#--

#add,sub
ori $s0,$0,1
ori $s1,$0,4
ori $s2,$0,15
lui $t0,0xfda3
ori $t0,$t0,0x34f5 #-
ori $t1,$0,0x234 #+
lui $t2,0x424
ori $t2,$t2,32853
add $a0,$t0,$t1 #-+
add $a1,$t0,$t0 #--
add $a2,$t1,$t1 #++
subu $a0,$t0,$t1 #-+
subu $a1,$t1,$t0 #+-
subu $a2,$t1,$t2 #++
subu $a3,$t2,$t1 #++
lui $t3,0xf39f
subu $a1,$t0,$t3 #--
subu $a2,$t3,$t0

#and,or,xor,nor
ori $s0,$0,1
ori $s1,$0,4
ori $s2,$0,15
lui $t0,0xfda3
ori $t0,$t0,0x34f5 #-
ori $t1,$0,0x234 #+
lui $t2,0x424
ori $t2,$t2,32853
and $a0,$t0,$t1 #-+
and $a1,$t0,$t0 #--
and $a2,$t1,$t1 #++
or $a0,$t0,$t1 #-+
or $a1,$t1,$t0 #+-
or $a2,$t1,$t2 #++
xor $a3,$t2,$t1 #++
xor $a0,$t0,$t1 #-+
xor $a1,$t1,$t0 #+-
xor $a2,$t1,$t2 #++
lui $t3,0xf39f
or $a1,$t0,$t3 #--
xor $a2,$t3,$t0
nor $a0,$t0,$t1 #-+
nor $a1,$t1,$t0 #+-
nor $a2,$t1,$t2 #++

#mult
lui $t0,0xfeaf
ori $t0,$t0,0x5254
lui $t1,0x0243
ori $t1,$t1,0x323f
mult $t0,$t0 #--
mfhi $a0
mflo $a1
mult $t1,$t0 #+-
mfhi $a0
mflo $a1
mult $t1,$t1 #-+
mfhi $a1
mflo $a0

#multu
lui $t0,0xfeaf
ori $t0,$t0,0x5254
lui $t1,0x0243
ori $t1,$t1,0x323f
multu $t0,$t0
mfhi $a0
mflo $a1
multu $t1,$t0
mfhi $a0
mflo $a1
multu $t1,$t1
mfhi $a0
mflo $a1

#div,divu
lui $t0,0xfeaf
ori $t0,$t0,0x5254
lui $t1,0x0243
ori $t1,$t1,0x323f
lui $t2,0xe120
ori $t2,$t2,0x300
ori $t3,$0,0x99
div $t0,$t1 #-+
mfhi $a0
mflo $a1
div $t1,$t0 
mfhi $a0
mflo $a1
div $t0,$t2 #--
mfhi $a0
mflo $a1
div $t2,$t0
mfhi $a0
mflo $a1
div $t1,$t3 #++
mfhi $a0
mflo $a1
div $t0,$t1 #-+
mfhi $a0
mflo $a1
div $t1,$t0 
mfhi $a0
mflo $a1
div $t0,$t2 #--
mfhi $a0
mflo $a1
div $t2,$t0
mfhi $a0
mflo $a1
div $t1,$t3 #++
mfhi $a0
mflo $a1

#mthi,mtlo
lui $t0,0xfeaf
ori $t0,$t0,0x5254
lui $t1,0x0243
ori $t1,$t1,0x323f
mult $t0,$t0
mthi $t0
mtlo $t1
mfhi $a0
mflo $a1
mult $t1,$t0
mthi $t1
mfhi $a0
mult $t1,$t1
mtlo $t0
mfhi $a0
mflo $a1

#sll,srl,sra
ori $t0,$t0,123
sll $t0,$t0,4
srl $t0,$t0,4
ori $t1,$t1,0xffff
sll $t1,$t1,2
srl $t1,$t1,2
sra $t0,$t0,3  #+
lui $t0,0xf234
sra $t1,$t0,3 #-
lui $t0,0x23
sra $t0,$t0,4 #+

#sllv,srlv,srav
ori $s0,$0,1
ori $s1,$0,4
ori $s2,$0,15
lui $t0,0xfda3
ori $t0,$t0,0x34f5
ori $t1,$0,0x234
lui $t2,0x424
ori $t2,$t2,32853
sllv $a0,$t0,$s0 #-
sllv $a1,$t1,$s1 #+
sllv $a3,$t2,$s2 #+
srlv $a0,$t0,$s0
srlv $a1,$t1,$s1
srlv $a3,$t2,$s2
srav $a0,$t0,$s0
srav $a0,$t0,$s1
srav $a1,$t1,$s1
srav $a3,$t2,$s2

#slt,sltu
ori $t0,$0,2
ori $t1,$0,1
ori $t2,$0,2
lui $t3,0xffff
slt $a0,$t2,$t1#++
slt $a1,$t3,$t1#-+
ori $t4,$t3,0x1234
slt $a2,$t3,$t4 #--
sltu $a0,$t2,$t1 #++
sltu $a1,$t3,$t1 #-+
sltu $a2,$t3,$t4 
sltu $a3,$t4,$t3

#jalr
ori $t0,$0,1
jal jalr_loop
ori $t0,$ra,0
ori $t2,$0,2
addu $a1,$a1,$a0
j jalr_end
ori $t6,$t6,6
jalr_loop:
addu $a0,$0,$ra
jalr $a0,$ra
ori $t4,$a0,0
ori $t5,$t5,5
jalr_end:

#addi,addiu,andi,xori
ori $s0,$0,1
ori $s1,$0,4
ori $s2,$0,15
lui $t0,0xfda3
ori $t0,$t0,0x34f5 #-
ori $t1,$0,0x234 #+
lui $t2,0x424
ori $t2,$t2,32853
addi $a0,$t0,0xea4
addi $a1,$t0,-134
addi $a2,$t1,0xf53f
addi $a3,$t1,533
addiu $a0,$t0,0xea4
addiu $a1,$t0,-134
addiu $a2,$t1,0xf53f
addiu $a3,$t1,533
andi $a0,$t0,0xea4
andi $a1,$t0,-134
andi $a2,$t1,0xf53f
andi $a3,$t1,533
xori $a0,$t0,0xea4
xori $a1,$t0,-134
xori $a2,$t1,0xf53f
xori $a3,$t1,533

#slti,sltiu
ori $t0,$0,2
ori $t1,$0,1
lui $t3,0xffff
slti $a0,$t1,2 #+
slti $a1,$t0,1
slti $a2,$t0,-100
slti $a3,$t3,2390
sltiu $a0,$t1,2 #+
sltiu $a1,$t0,1
sltiu $a2,$t0,-100 #-
sltiu $a3,$t3,2390

#sw,sh,sb,lh.lhu,lb,lbu
ori $20,$0,1
lui $21,0xffff
ori $21,$21,0xffff
lui $3,0xf3f4
ori $3,$3,0x71f2
sw $3,0($0)
sh $3,8($0)
sh $3,10($0)
sb $3,4($0)
sb $3,5($0)
sb $3,6($0)
sb $3,7($0)
lh $2,0($0)
lh $2,2($0)
lhu $2,0($0)
lhu $2,2($0)
lb $2,0($0)
lb $2,1($0)
lb $2,2($0)
lb $2,3($0)
lbu $2,0($0)
lbu $2,1($0)
lbu $2,2($0)
lbu $2,3($0)

#bne
ori $t0,$0,1
bne $t0,$t0,bne_label1
ori $t1,$0,1
ori $t2,$0,2
bne $t0,$t2,bne_label1
ori $t3,$0,3
ori $t4,$0,4
bne_label1:ori $t3,$t3,3

#blez,bgtz
ori $a1,$0,1
lui $a2,0xf433
blez $a1,blez_label1
ori $t0,$t0,1
ori $t1,$t1,2
ori $a0,$0,0
blez $a0,blez_label1
ori $t2,$t2,2
ori $t3,$t3,3
blez_label1:ori $t4,$t4,4
blez $a2,bgez_label2
ori $t5,$t5,5
ori $t6,$t6,6
blez_label2:ori $t7,$t7,7
bgtz $a2,bgtz_label3
ori $t0,$t0,1
ori $t1,$t1,2
bgtz $a0,bgtz_label3
ori $t2,$t2,2
ori $t3,$t3,3
bgtz $a1,bgtz_label3
ori $t5,$t5,5
ori $t6,$t6,6
bgtz_label3:ori $t4,$t4,4

#bltz,bgez
ori $a1,$0,1
lui $a2,0xf433
bgez $a2,bgez_label1
ori $t0,$t0,1
ori $t1,$t1,2
ori $a0,$0,0
bgez $a0,bgez_label1
ori $t2,$t2,2
ori $t3,$t3,3
bgez_label1:ori $t4,$t4,4
bgez $a1,bgez_label2
ori $t5,$t5,5
ori $t6,$t6,6
bgez_label2:ori $t7,$t7,7
bltz $a1,bgez_label3
ori $t0,$t0,1
ori $t1,$t1,2
bltz $a0,bgez_label3
ori $t2,$t2,2
ori $t3,$t3,3
bltz $a2,bgez_label3
ori $t5,$t5,5
ori $t6,$t6,6
bgez_label3:ori $t4,$t4,4


ori $t0,$0,8
sw $t1,-8($t0)
sw $t2,0($t0)
sw $t3,8($t0)
lw $t4,-8($t0)
lw $t5,0($t0)
lw $t6,8($t0)

 #测试跳转及延迟槽
jal loop1
ori $t0,$0,233
nop
j test
ori $t0,$0,555
ori $t0,$0,342
test:
ori $t0,0
ori $t1,$0,1
beq $t0,$t1,test1
ori $t2,$0,1
nop
beq $t1,$t2,test1
ori $t3,3
ori $t4,4
test1:
ori $t0,$0,0

#冲突测试
#需要初始化内存单元
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
#MU-M-RS
mult $t0,$t0
mfhi $a0
addu $t2,$a0,$t0
#MU-M-RT
mflo $a0
addu $t2,$t1,$a0
#MU-W-RS
mult $t1,$t1
mfhi $a1
nop
addu $t2,$a1,$t0
#MU-W-RT
mflo $a2
nop
addu $t0,$t0,$a2
#MU-W-RT
mfhi $a1
sw $a1,444($0)
#R-M-RS
addu $a3,$a1,$a2
mtlo $a3
mflo $a2
#R-W-RS
addu $a3,$a1,$a2
nop
mtlo $a3
mflo $a2
#I-M-RS
ori $a2,$a1,1234
mtlo $a2
mflo $a1
#I-W-RS
xori $a3,$a2,1234
nop
mtlo $a3
mflo $a1

#LD-W-RT
lw $a0,0($0)
mthi $a0
mfhi $a0
#LD-W-RT
lw $a1,4($0)
nop
mthi $a1
mfhi $a1
#LD-W-RT
lw $a2,8($0)
nop
nop
mthi $a2
mfhi $a2
#MDZZ-MDZZ
mult $a1,$a2
div $a0,$a2
mfhi $1
mflo $2
#
mult $a0,$a1
mthi $a3
mtlo $a0
mfhi $3
mflo $4
#mdzz-R-mthi-RS
mult $a1,$a2
addu $a3,$1,$2
mthi $a3
mfhi $4
mflo $5
#mdzz-R-X-mthi-RS
multu $4,$5
subu $3,$2,$1
nop
mtlo $3
mfhi $5
mflo $6
#mdzz-R-mdzz-rs
mult $1,$4
srav $8,$4,$3
multu $8,$4
mfhi $1
mflo $2
#mdzz-R-mdzz-RT
mult $2,$6
srav $9,$5,$3
mult $5,$9
mfhi $1
mflo $2
#mdzz-r-x-mdzz-rs
mult $2,$4
srav $8,$4,$2
nop
multu $8,$5
mfhi $1
mflo $2
#mdzz-r-x-mdzz-rt
mult $4,$6
srav $9,$7,$3
nop
mult $1,$9
mfhi $1
mflo $2
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
#MU-M-RS
mult $t0,$t0
mfhi $a0
ori $t0,$a0,3415
#MU-W-RS
mult $t1,$t1
mflo $a1
nop
ori $t0,$a1,328
#mu-w-rt
mflo $1
sw $1,888($0)
mflo $2
nop
sw $2,884($0)
mflo $3
nop
nop
sw $3,880($0)


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
nop
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
#JAL-M-RS
jal label1
mthi $31
nop
label1:mfhi $14
jal label2
nop
nop
label2:mthi $31
mfhi $15
jal label3
nop
nop
label3:nop
mthi $31
mfhi $16

#MU-E-RS
lui $t0,0xfe23
ori $t0,$t0,0x24f5
lui $t1,0x948
ori $t1,$t1,0x8840
ori $a0,$0,0
mult $t1,$t1
mfhi $a0
beq $a0,$0,wrong
nop
#MU-E-RT
ori $a1,$0,0
mflo $a1
beq $0,$a1,wrong
nop
#MU-M-RS
mult $t0,$t0
ori $a0,$0,0
mfhi $a0
nop
beq $a0,$0,wrong
nop
#MU-M-RT
ori $a1,$0,0
mflo $a1
nop
beq $0,$a1,wrong
nop
#MU-W-RS
mult $t0,$t0
ori $a0,$0,0
mfhi $a0
nop
nop
beq $a0,$0,wrong
nop
#MU-W-RT
ori $a1,$0,0
mflo $a1
nop
nop
beq $0,$a1,wrong
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
#MU-W-RT
lui $t1,0x948
ori $t1,$t1,0x8840
ori $a0,$0,0
mult $t1,$t1
mfhi $a0
sw $a0,0($0)

#mult
#mult,RSuse,RTuse在E
lui $t1,0xf284
ori $t1,$t1,516
lui $t2,0x344
ori $t2,$t2,233
#R-M-RS
addu $a0,$t1,$t2
mult $a0,$t1
mfhi $a0
mflo $a2
#R-M-RT
addu $a1,$t1,$t1
mult $t2,$a1
mfhi $a1
mflo $a2
#R-W-RS
addu $a0,$t2,$t2
nop
mult $a0,$t1
mfhi $a1
mflo $a2
#R-W-RT
addu $t1,$t1,$t2
nop
mult $a0,$t1
mfhi $a0
mflo $a2
#I-M-RS
ori $a0,$0,0x324
mult $a0,$t0
mfhi $a0
mflo $a2
#I-M-RT
ori $a1,$0,0x4242
mult $t0,$a1
mflo $a1
#I-W-RS
ori $a0,$0,0x3343
nop
mult $a0,$t0
nop
mfhi $a0
mflo $a2
#I-W-RT
ori $a1,$0,0xf242
nop
mult $t0,$a1
nop
mflo $a1
#LD-M-RS
lw $t0,0($0)
mult $t0,$a1
mfhi $a0
#LD-M-RT
lw $t0,4($0)
mult $a0,$t0
mflo $a2
#LD-W-RS
lw $t0,8($0)
nop
mult $t0,$a1
mfhi $a1
mflo $a2
#LD-W-RT
lw $t0,12($0)
nop
mult $a1,$t0
mfhi $a0
mflo $a1
#JAL-M-RS
ori $a0,0x4248
jal loop1
mult $ra,$a0
mfhi $a0
mflo $a1
#JAL-M-RT
jal loop2
mult $a1,$ra
mfhi $a2
mflo $a1
#JAL-W-RS
jal loop1
nop
mult $ra,$a2
mfhi $a2
mflo $a3
#JAL-W-RT
jal loop2
nop
mult $a3,$ra
mfhi $t0
mflo $a2

j end
nop

wrong:
ori $s0,$0,2333

loop1:
jr $ra
nop
nop

loop2:
jr $ra
nop
nop
end:

