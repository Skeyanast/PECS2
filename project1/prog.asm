$MOD51
ORG 0h
START:
    SETB P1.0
    ACALL DELAY
    CLR P1.0
    ACALL DELAY
    SJMP START

DELAY:
    MOV R0, #255
LOOP:
    DJNZ R0, LOOP
    RET
END