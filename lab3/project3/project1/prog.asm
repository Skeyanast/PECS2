$MOD51   ; Include 8051 SFR definitions

; Time constants (for 12 MHz clock)
S_TIME EQU 7    ; LED ON time (seconds)
K_TIME EQU 6    ; LED OFF time (seconds)
T_MIN  EQU 15   ; Total duration (minutes)

; Timer value for 50ms interrupt (12 MHz clock)
; Calculation: 65536 - (50000 ? 12)/12 = 15536
TIMER_VAL EQU 15536 

; Reset and interrupt vectors
org 00h
    jmp start       ; Jump to main program

org 0Bh            ; Timer 0 interrupt vector
    ljmp timer_isr  ; Jump to interrupt handler

; Main program starts at 30h to avoid overlap with interrupt vector
org 30h
start:
    ; Timer initialization
    mov tmod, #01h   ; Set Timer 0 to mode 1 (16-bit timer)
    
    ; LED initialization (connected to P3.3)
    mov p3, #00h     ; Clear all P3 pins
    setb p3.3        ; Turn LED off (active low logic)
    
    ; Initialize counters
    mov r0, #0       ; 50ms interval counter
    mov r1, #S_TIME  ; ON time counter (7 seconds)
    mov r2, #K_TIME  ; OFF time counter (6 seconds)
    mov r3, #T_MIN   ; Total duration counter (15 minutes)
    
    ; Interrupt configuration
    setb ea          ; Enable global interrupts
    setb et0         ; Enable Timer 0 interrupt
    setb tr0         ; Start Timer 0
    
; Main infinite loop (all logic handled in interrupts)
main_loop:
    sjmp main_loop   ; Wait indefinitely

; Timer 0 interrupt service routine
timer_isr:
    clr tr0          ; Stop timer temporarily
    
    ; Reload timer value for 50ms
    mov tl0, #low(TIMER_VAL)
    mov th0, #high(TIMER_VAL)
    
    setb tr0         ; Restart timer
    
    inc r0           ; Increment 50ms counter
    cjne r0, #20, exit_isr  ; Check if 1 second passed (20?50ms)
    
    ; 1 second has elapsed
    mov r0, #0       ; Reset 50ms counter
    
    ; Check current LED state
    jb p3.3, led_off ; Jump if LED is currently OFF
    
; LED is ON - handle ON duration
led_on:
    djnz r1, exit_isr ; Decrement ON counter, exit if not zero
    
    ; 7 seconds ON time completed
    setb p3.3         ; Turn LED OFF
    mov r1, #S_TIME   ; Reset ON counter
    sjmp exit_isr
    
; LED is OFF - handle OFF duration    
led_off:
    djnz r2, exit_isr ; Decrement OFF counter, exit if not zero
    
    ; 6 seconds OFF time completed
    clr p3.3          ; Turn LED ON
    mov r2, #K_TIME   ; Reset OFF counter
    
    ; Check total duration
    djnz r3, exit_isr ; Decrement minute counter, exit if not zero
    
    ; 15 minutes completed
    clr ea            ; Disable all interrupts
    setb p3.3         ; Ensure LED is OFF
    sjmp $            ; Halt program (infinite loop)

exit_isr:
    reti              ; Return from interrupt

END