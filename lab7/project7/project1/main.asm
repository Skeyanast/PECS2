$MOD51

VAL_LOW  DATA 30h
VAL_HIGH DATA 31h

ORG 0000h
    LJMP MAIN

ORG 0030h
MAIN:
    MOV P1, #0FFh
    MOV P3, #0FFh
    MOV P0, #00h
    MOV P2, #00h
    
    CLR P3.6
    SETB P3.6
    
    MOV VAL_LOW, P1
    MOV VAL_HIGH, P3
    
    MOV P0, VAL_LOW
    MOV P2, VAL_HIGH
    
LOOP:
    SJMP LOOP
    
END