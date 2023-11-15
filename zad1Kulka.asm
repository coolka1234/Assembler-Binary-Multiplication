.data
licz1:  .word 1335
licz2:  .word 76
status: .word 0
wyn:    .word 0
msg_overflow: .asciiz " Overflow"
.text

	lw $s0,licz1 # wartosc licz1 z pamieci statycznej do rejestru s0
	lw $s1,licz2 # wartosc licz2 z pamieci statycznej do rejestru s1
	
	li $s2,0 # wynik ustawiamy na 0
loop:	
	beqz $s1, finish # sprawdzamy czy mnozna jest rowna 0
	# jezeli nie jest
	and $t0, $s1 1 # sprawdzamy czy na najmniej znaczacym bicie jest wartosc 1
	beqz $t0, skip  
	add $s2,$s2,$s0 # dodajemy wartosc mnozona do wyniku
skip:
	sll $s0,$s0,1 # mnozymy mnoznik przez 2 
	srl $s1,$s1,1 # dzielimy mnozna przez 2 
	j loop # wracamy go label loop
	
finish:
	move $a0, $s2
	li $v0, 1
	syscall # print wyniku
	sw $s2, wyn #zapis wyniku do pamieci statycznej
	#lw $t0, licz1
	#lw $t1, licz2
	#or $t2, $t0, $t1    # sprawdzamy ile bitow maja lacznie obie zmienne
	#srl $t3, $t2, 31    # sprawdzamy najwazniejszy bit
	#beqz  $t3, overflow
	#li $v0, 4
     	#la $a0, msg_overflow
	#overflow:
     	#syscall
	li $v0, 10
	syscall
