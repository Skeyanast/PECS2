$MOD51

ORG 00h
MOV SCON, #50h
MOV TMOD, #20h
MOV TH1, #0E8h
SETB TR1
MOV R0, #50h
MOV R1, #10

LOOP:
	JNB RI, $
	MOV A, SBUF
	MOV @R0, A
	CLR RI
	INC R0
	DJNZ R1, LOOP

SJMP $

END