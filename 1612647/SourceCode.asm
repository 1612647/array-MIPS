.data
array: .space 40
n: .word 0
TBNhap1: .asciiz "Nhap n: "
TBNhap2: .asciiz "a["
TBNhap3: .asciiz "]: "
TBXuat1: .asciiz "Mang a: "
TBXuat2: .asciiz "Mang rong\n"
Menu: .asciiz "\n==========Menu==========\n1. Nhap lai mang\n2. Xuat mang\n3. Liet ke so nguyen to trong mang\n4. Liet ke so hoan thien trong mang\n5. Tinh tong cac so chinh phuong\n6. Tinh trung binh cong cac so chinh phuong\n7. Tim gia tri lon nhat\n8. Sap xep mang tang dan Selection Sort\n9. Sap xep mang giam dan Bubble Sort\n0. Thoat\n==============\n\tChon: "
TBXuat3: .asciiz "Liet ke cac so nguyen to: "
TBXuat4: .asciiz "Liet ke cac so hoan thien: "
TBXuat5: .asciiz "Tong cac so chinh phuong: "
TBXuat6: .asciiz "Trung binh cong cac so doi xung: "
TBXuat7: .asciiz "Gia tri lon nhat: "
TBXuat8: .asciiz "Sap xep tang dan (Selection Sort): "
TBXuat9: .asciiz "Sap xep giam dan (Bubble Sort): "
TBNull: .asciiz "Khong co.\n"
TBNhapSai: .asciiz "\nNhap sai gia tri lua chon. Xin vui long chon lai!\n"
.text
   .globl main
main:


_NhapMang:
	la $a0,TBNhap1	#Xuat thong bao nhap n
	li $v0,4
	syscall
	li $v0,5	#Nhap n
	syscall
	
	beq $v0,0,XuatMenu	#Kiem tra n = 0
	li $t2,0
	slt $t1,$v0,$t2
	beq $t1,1,_NhapMang	#Kiem tra n < 0 thi nhap lai

	sw $v0,n	#Luu lai
	lw $s1,n	#Dua n vao $s1

	#Khoi tao vong lap 
	li $t0,0 #gan i = 0
	la $s0,array #Load mang vao $s0
_NhapMang.Lap:
	
	la $a0,TBNhap2	#Xuat thong bao nhap phan tu: a[
	li $v0,4
	syscall
	
	move $a0,$t0	#Xuat chi so i
	li $v0,1
	syscall

	la $a0,TBNhap3	#Xuat thong bao nhap phan tu: ]:
	li $v0,4
	syscall

	li $v0,5	#Nhap vao so nguyen
	syscall

	sw $v0,($s0)	#Luu vao mang

	addi $s0,$s0,4	#Sang phan t ke tiep
	addi $t0,$t0,1	#Tang i++
	
	slt $t1,$t0,$s1	#DIeu kien lap
	beq $t1,1,_NhapMang.Lap
	#s1: n, $t0: i, $s0: array
	#$t0: tmp
	j XuatMenu
XuatMenu:

	#Xuat menu
	li $v0,4
	la $a0,Menu
	syscall

	#Nhap gia tri lua chon
	li $v0,5
	syscall

	#Luu vao $t2
	move $t2,$v0

	beq $t2,1,_NhapMang
	beq $t2,2,_XuatMang
	beq $t2,3,_LietKeSoNguyenTo
	beq $t2,4,_LietKeSoHoanThien
	beq $t2,5,_TinhTongSoChinhPhuong
	beq $t2,6,_TinhTrungBinhCongSoDoiXung
	beq $t2,7,_TimGiaTriLonNhat
	beq $t2,8,_SapXepTangDanSelectionSort
	beq $t2,9,_SapXepGiamDanBubbleSort
	beq $t2,0,_Thoat
	j _NhapSai

_XuatMang:
	la $a0,TBXuat1	#Xuat thong bao
	li $v0,4
	syscall
	
	beq $s1,0,_XuatMang.TBMangRong	#Kiem tra mang rong
	
	#Khoi tao vong lap 
	li $t0,0 #gan i = 0
	la $s0,array #Load mang vao $s0
_XuatMang.Lap:
	lw $a0,($s0)	#Load gia tri phan tu tu mang
	li $v0,1	#Xuat phan tu
	syscall

	li $a0,32	#Xuat khoang trang
	li $v0,11
	syscall

	addi $s0,$s0,4	#Sang phan tu tiep theo
	addi $t0,$t0,1	#i++

	slt $t1,$t0,$s1	#Dieu kien lap
	beq $t1,1,_XuatMang.Lap
	
	j XuatMenu
_XuatMang.TBMangRong:
	la $a0,TBXuat2	#Xuat thong bao mang rong
	li $v0,4
	syscall
##3
_LietKeSoNguyenTo:
	#Khoi tao vong lap 
	li $t0,0 	#gan i = 0
	la $s0,array 	#Load mang vao $s0
_LietKeSoNguyenTo.Lap:

	lw $a0,($s0)		#Lay phan tu tu mang
	jal _KiemTraNguyenTo	#Ham kiem tra
	move $t1,$v0		#Luu ket qua vao $t1
	beq $t1,0,_LietKeSoNguyenTo.TiepTucLap	#Neu khong phai so nguyen to thi sang phan tu ke tiep 
	jal _LietKeSoNguyenTo.Xuat	#Xuat neu la so nguyen to

_LietKeSoNguyenTo.TiepTucLap:
	addi $s0,$s0,4	#Sang phan tu tiep theo
	addi $t0,$t0,1	#i++

	slt $t2,$t0,$s1	#Dieu kien lap
	beq $t2,1,_LietKeSoNguyenTo.Lap

	j XuatMenu

_LietKeSoNguyenTo.Xuat:
	li $v0,1	#Xuat
	syscall

	li $a0,32	#Xuat khoang trang
	li $v0,11
	syscall

	jr $ra		#Tiep tuc lap

##4
_LietKeSoHoanThien:
	#Khoi tao vong lap 
	li $t0,0 	#gan i = 0
	la $s0,array 	#Load mang vao $s0
_LietKeSoHoanThien.Lap:

	lw $a0,($s0)		#Lay phan tu tu mang
	jal _KiemTraHoanThien	#Ham kiem tra
	move $t1,$v0		#Luu ket qua vao $t1hoan thiennguyen to thi sang phan tu ke tiep 
	jal _LietKeSoHoanThien.Xuat	#Xuat neu la so hoan thien

_LietKeSoHoanThien.TiepTucLap:
	addi $s0,$s0,4	#Sang phan tu tiep theo
	addi $t0,$t0,1	#i++

	slt $t2,$t0,$s1	#Dieu kien lap
	beq $t2,1,_LietKeSoHoanThien.Lap

	j XuatMenu

_LietKeSoHoanThien.Xuat:
	li $v0,1	#Xuat
	syscall

	li $a0,32	#Xuat khoang trang
	li $v0,11
	syscall

	jr $ra		#Tiep tuc lap
##5
_TinhTongSoChinhPhuong:
	#Khoi tao vong lap 
	li $t0,0 	#gan i = 0
	la $s0,array 	#Load mang vao $s0
	li $s2,0	#Gan Tong = 0
_TinhTongSoChinhPhuong.Lap:
	lw $a0,($s0)		#Lay phan tu tu mang
	jal _KiemTraChinhPhuong	#Ham kiem tra
	move $t1,$v0		#Luu ket qua vao $t1
	beq $t1,0,_TinhTongSoChinhPhuong.TiepTucLap	#Neu khong phai so chinh phuong thi sang phan tu ke tiep 
	
	add $s2,$s2,$a0		#Cong don vao $s2 neu la so chinh phuong

_TinhTongSoChinhPhuong.TiepTucLap:
	addi $s0,$s0,4	#Sang phan tu tiep theo
	addi $t0,$t0,1	#i++

	slt $t2,$t0,$s1	#Dieu kien lap i < n
	beq $t2,1,_TinhTongSoChinhPhuong.Lap

	la $a0,TBXuat5	#Xuat thong bao
	li $v0,4
	syscall
	move $a0,$s2	#Xuat tong
	li $v0,1
	syscall
	
	j XuatMenu

##6
_TinhTrungBinhCongSoDoiXung:
#Khoi tao vong lap 
	li $t0,0 	#gan i = 0
	la $s0,array 	#Load mang vao $s0
	li $s2,0	#Gan Tong = 0
	li $s3,0	#Dem so doi xung
_TinhTrungBinhCongSoDoiXung.Lap:
	lw $a0,($s0)		#Lay phan tu tu mang
	jal _KiemTraDoiXung	#Ham kiem tra
	move $t1,$v0		#Luu ket qua vao $t1
	beq $t1,0,_TinhTrungBinhCongSoDoiXung.TiepTucLap	#Neu khong phai so doi xung thi sang phan tu ke tiep 
	
	add $s2,$s2,$a0		#Cong don vao $s2 neu la so doi xung
	addi $s3,$s3,1		#dem++

_TinhTrungBinhCongSoDoiXung.TiepTucLap:
	addi $s0,$s0,4	#Sang phan tu tiep theo
	addi $t0,$t0,1	#i++

	slt $t2,$t0,$s1	#Dieu kien lap i < n
	beq $t2,1,_TinhTrungBinhCongSoDoiXung.Lap

	la $a0,TBXuat6	#Xuat thong bao
	li $v0,4
	syscall

	div $s2,$s3	#Trung binh cong = Tong/n
	mflo $a0	

	li $v0,1
	syscall
	
	j XuatMenu
##7
_TimGiaTriLonNhat:
#Khoi tao vong lap 
	li $s2,0
	beq $s1,$s2,_TimGiaTriLonNhat.XuatKhongCo	#Neu n = 0

	li $t0,1	#gan i = 1
	la $s0,array 	#Load mang vao $s0
	lw $s2,	($s0)	#Gan Max = a[0]
	addi $s0,$s0,4	#Sang phan tu tiep theo
_TimGiaTriLonNhat.Lap:
	
	slt $t2,$s2,$s0	#neu a[i] <= max
	beq $t2,0,_TimGiaTriLonNhat.TiepTucLap
	
	lw $s2,($s0)
_TimGiaTriLonNhat.TiepTucLap:
	addi $s0,$s0,4	#Sang phan tu tiep theo
	addi $t0,$t0,1	#i++

	slt $t2,$t0,$s1	#Dieu kien lap i < n

	la $a0,TBXuat7	#Xuat thong bao
	li $v0,4
	syscall

	move $a0,$s2		#Xuat max
	li $v0,1
	syscall
	j XuatMenu

_TimGiaTriLonNhat.XuatKhongCo:
	la $a0,TBNull
	li $v0,4	
	j XuatMenu


_NhapSai:
	# xuat tb8
	li $v0,4
	la $a0,TBNhapSai
	syscall
	j XuatMenu
_Thoat:
	li $v0,10
	syscall

##Hamkiem tra so nguye nto
#Dau thu tuc
_KiemTraNguyenTo:
	#Khai bao kich thuoc stack
	addi $sp,$sp,-16
	
	#Backup thanh ghi
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)

#Than thu tuc:
	#khoi tao vong lap
	li $s0,	0 # Dem = 0
	li $t0, 1 # i = 1
_KiemTraNguyenTo.Lap:
	div $a0,$t0
	mfhi $t1
	
	#Kiem tra phan du
	beq $t1,0,_KiemTraNguyenTo.TangDem
	j _KiemTraNguyenTo.Tangi

_KiemTraNguyenTo.TangDem:
	addi $s0,$s0,1

_KiemTraNguyenTo.Tangi:
	addi $t0,$t0,1

	#Kiem tra deiu kien lap: i <= n
	slt $t1,$a0,$t0
	beq $t1,0,_KiemTraNguyenTo.Lap
	
	#Kiem tra dem
	beq $s0,2,_KiemTraNguyenTo.Return
	#Return 0
	li $v0,0
	j _KiemTraNguyenTo.KetThuc

_KiemTraNguyenTo.Return:
	li $v0,1

_KiemTraNguyenTo.KetThuc:
	#Restore thanh ghi
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)

	#Xoa stack
	addi $sp,$sp,16

	#Nhay ve dia chi goi ham
	jr $ra
	
##Ham kiem tra so hoan thien
#dau thu tuc
_KiemTraHoanThien:

	#Khai bao kich thuoc stack
	addi $sp,$sp,-16
	
	#Backup thanh ghi
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)

#Than thu tuc:
	#khoi tao vong lap
	li $s0,	0 # sum = 0
	li $t0, 1 # i = 1

_KiemTraHoanThien.Lap:
	div $a0,$t0
	mfhi $t1	#lay so dý
	
	#Kiem tra phan du
	beq $t1,0,_KiemTraHoanThien.TangTong
	j _KiemTraHoanThien.Tangi

_KiemTraHoanThien.TangTong:
	add $s0,$s0,$t0

_KiemTraHoanThien.Tangi:
	addi $t0,$t0,1	#i++

	#Dieu kien lap: i < n. 
	slt $t1,$t0,$a0
	beq $t1,1,_KiemTraHoanThien.Lap
	
	#Kiem tra Tong != $a0
	bne $s0,$a0,_KiemTraHoanThien.ReturnFalse
	beq $a0,1,_KiemTraHoanThien.ReturnFalse
	#Return true (1)
	li $v0,1
	j _KiemTraHoanThien.KetThuc

_KiemTraHoanThien.ReturnFalse:
	li $v0,0

_KiemTraHoanThien.KetThuc:
	#Restor thanh ghi
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)

	#Xoa stack
	addi $sp,$sp,16

	#Nhay ve dia chi goi ham
	jr $ra


##Ham kiem tra so chinh phuong
#dau thu tuc
_KiemTraChinhPhuong:

	#Khai bao kich thuoc stack
	addi $sp,$sp,-16
	
	#Backup thanh ghi
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)

#Than thu tuc:
	#khoi tao vong lap
	li $t0, 0 # i = 0

_KiemTraChinhPhuong.Lap:
	mult $t0,$t0	#Gan $t1 = i*i
	mflo $t1
	
	beq $t1,$a0,_KiemTraChinhPhuong.ReturnTrue	#Tra ve 1 neu dung

	j _KiemTraChinhPhuong.Tangi

_KiemTraChinhPhuong.Tangi:
	addi $t0,$t0,1	#i++

	#Dieu kien lap: i <= n. 
	slt $t1,$a0,$t0
	beq $t1,0,_KiemTraChinhPhuong.Lap
	
	#Return false (0)
	li $v0,0
	j _KiemTraChinhPhuong.KetThuc

_KiemTraChinhPhuong.ReturnTrue:
	li $v0,1

_KiemTraChinhPhuong.KetThuc:
	#Restor thanh ghi
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)

	#Xoa stack
	addi $sp,$sp,16

	#Nhay ve dia chi goi ham
	jr $ra



##Ham kiem tra so doi xung
_KiemTraDoiXung:
	#Khai bao kich thuoc stack
	addi $sp,$sp,-16
	
	#Backup thanh ghi
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)

#Than thu tuc:
	slt $t0,$a0,$zero	#Kiem tra so am
	beq $t0,1,_KiemTraDoiXung.ReturnFalse	

	li $s0,0	#Khoi tao nghich dao

	#khoi tao vong lap
	addi $t0,$a0,0 # i = $a0

_TimSoDoiXung.Lap:
	li $t1,10
	mult $s0,$t1	#$s0 = $s0 * 10
	mflo $s0
	div $t0,$t1	#$t1 = $t0 % 10
	mfhi $t1
	add $s0,$s0,$t1 #$s0 = ($s0 * 10) + ($t0 % 10)

	j _TimSoDoiXung.iChia10	#i=i/10

_TimSoDoiXung.iChia10:
	li $t1,10
	div $t0,$t1	#i/10
	mflo $t0

	#Dieu kien lap: i != 0. 
	bne $t0,0,_TimSoDoiXung.Lap
	
	#Ki?m tra so doi xung != so ban dau
	bne $s0,$a0,_KiemTraDoiXung.ReturnFalse	#Tra ve 0

	#Return true (1)
	li $v0,1
	j _KiemTraDoiXung.KetThuc

_KiemTraDoiXung.ReturnFalse:
	li $v0,0

_KiemTraDoiXung.KetThuc:
	#Restor thanh ghi
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)

	#Xoa stack
	addi $sp,$sp,16

	#Nhay ve dia chi goi ham
	jr $ra

##8 Sap xep
_SapXepTangDanSelectionSort:
	addi $t0, $0, 1
	la $a1, array
	addi $a1, $a1, 4
_SapXepTangDanSelectionSort.Lap1:
	beq $t0, $s1, _SapXepTangDanSelectionSort.KetThuc
	lw $t1, ($a1)
	addi $t2, $t0, 0
	la $a2, ($a1)
_SapXepTangDanSelectionSort.Lap2:
	blez $t2, _SapXepTangDanSelectionSort.DK
	la $a3, ($a2)
	addi $a3, $a3, -4
	lw $t4, ($a3)
	ble $t4, $t1, _SapXepTangDanSelectionSort.DK
	la $a3, ($a2)
	addi $a3, $a3, -4
	lw $t5, ($a3)
	sw $t5, ($a2)
	addi $t2, $t2, -1
	addi $a2, $a2, -4
	j _SapXepTangDanSelectionSort.Lap2
_SapXepTangDanSelectionSort.DK:
	sw $t1, ($a2)
	addi $t0, $t0, 1
	addi $a1, $a1, 4
	j _SapXepTangDanSelectionSort.Lap1
_SapXepTangDanSelectionSort.KetThuc:
	j _XuatMang
	j XuatMenu


##9 
_SapXepGiamDanBubbleSort:

	add $t0,$zero,$zero #Khoi tao vong lap 1: i=0

_SapXepGiamDanBubbleSort.Lap1:
	addi $t0,$t0,1 #i++
	slt $t2,$s1,$t0
	beq $t2,1,_SapXepGiamDanBubbleSort.KetThuc #Dieu kien lap

	add $t1,$s1,$zero #Khoi tao vong lap 2: j=n
_SapXepGiamDanBubbleSort.Lap2:

	slt $t2,$t0,$t1
	beq $t2,0,_SapXepGiamDanBubbleSort.Lap1 #j < = i


	addi $t1,$t1,-1 #j--

	#So sanh
	li $t2,4
	mul $t4,$t1,$t2 #t4+a0=table[j]
	addi $t3,$t4,-4 #t3+a0=table[j-1]
	add $t7,$t4,$s0 #t7=table[j]
	add $t8,$t3,$s0 #t8=table[j-1]
	lw $t5,0($t7)
	lw $t6,0($t8)

	slt $t2,$t6,$t5
	beq $t2,1,_SapXepGiamDanBubbleSort.Lap2

	#Hoans vi
	sw $t5,0($t8)
	sw $t6,0($t7)
	j _SapXepGiamDanBubbleSort.Lap2

_SapXepGiamDanBubbleSort.KetThuc:
	j _XuatMang
	j XuatMenu
