$MOD51 ; Include MK-51 microcontroller
org 00h ; Start program at address 00h
mov dptr,#00h ; Load 00h into the pointer register
mov r2,#0ffh ; Load 0ffh into register R2 (loop counter)
mov r1,#055h ; Load 55h into register R1
test:
mov a,r1 ; Load accumulator ACC with operand from register R1
movx @dptr,a ; Transfer the contents of accumulator ACC to XRAM external memory cell
movx a,@dptr ; Read into accumulator the contents of current external memory cell
xrl a,#055h ; XOR operation between read and original operand, if 0 in ACC, then cell works correctly
jnz error ; Error - exit program
inc dptr ; Increment contents of DPTR register - move to next address
djnz r2,test ; Subtract 1 from contents of register R2 and jump to label if not 0
error:
END