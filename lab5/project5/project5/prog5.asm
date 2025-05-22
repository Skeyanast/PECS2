$MOD51

org 20h
mov r2, #9

ind:
	mov a, r2
	mov r3, #255
	mov dptr, #zg
	movc a, @a+dptr

ind1:
	mov p2, a
	nop
	nop
	djnz r3, ind1
	djnz r2, ind
	org 0100h

zg:
	db 11000000b
	db 11111001b
	db 10100100b
	db 10110000b
	db 10011001b
	db 10010010b
	db 10000010b
	db 11111000b
	db 10000000b
	db 10010000b

END