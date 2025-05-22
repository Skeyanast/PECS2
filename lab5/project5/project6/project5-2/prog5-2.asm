$MOD51	; This includes 8051 definitions for the Metalink assembler

ORG 00H
JMP START


SEG_TABLE:
    DB 0C0H, 0F9H, 0A4H, 0B0H, 99H, 92H, 82H, 0F8H, 80H, 90H


A_BCD EQU 23H
B_BCD EQU 52H

START:
    MOV A, #A_BCD
    ADD A, #B_BCD
    DA A
    
    MOV B, #10H
    DIV AB
    MOV R0, A
    MOV R1, B

MAIN_LOOP:

    MOV P2, #11111110B
    MOV A, R0
    ACALL DISPLAY_DIGIT
    ACALL DELAY
    
    MOV P2, #11111101B
    MOV A, R1
    ACALL DISPLAY_DIGIT
    ACALL DELAY
    
    JMP MAIN_LOOP

DISPLAY_DIGIT:
    MOV DPTR, #SEG_TABLE
    MOVC A, @A+DPTR
    MOV P1, A
    RET

DELAY:
    MOV R3, #10
DELAY_LOOP:
    MOV R4, #200
    DJNZ R4, $
    DJNZ R3, DELAY_LOOP
    RET

END