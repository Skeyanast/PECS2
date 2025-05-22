$MOD51	; This includes 8051 definitions for the Metalink assembler

ORG 00H
JMP MAIN

VAR:
    DB 59
    DB 144
    DB 217

MAIN:
    MOV P2, #00H
    
    MOV R0, #0
    MOV DPTR, #VAR

LOOP:
    MOV A, R0
    MOVC A, @A+DPTR
    MOV P2, A
    
    MOV R1, #200
DELAY_1:
    MOV R2, #250
DELAY_2:
    DJNZ R2, DELAY_2
    DJNZ R1, DELAY_1
    
    INC R0
    CJNE R0, #3, LOOP

ENDLESS:
    SJMP ENDLESS

END