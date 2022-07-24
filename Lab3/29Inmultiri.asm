bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db -8
    b db -32
    c db 4
    d dd 10
    x dq 12
    r resb 1

; our code starts here
segment code use32 class=code
    start:
        ; ... (a+b)/(c-2)-d+2-x; a,b,c-byte; d-doubleword; x-qword
        ; operatii cu semn
        mov al , [a] ; al = a = -8
        add al , [b] ; al = a+b = - 40
        cbw          ; ax = a+b = - 40
        mov bl , [c] ; bl = c = 4
        sub bl , 2   ; bl = (c-2) = 4 - 2 = 2
        
        idiv bl      ; al = ax/bl = -40/2 = -20  si  ah = ax%bl = 0
        mov [r] , ah ; r = ah = ax%bl = 0
        
        cbw          ; ax = al = (a+b)/(c-2) = -20
        cwde         ; eax = (a+b)/(c-2) = -20
        sub eax , [d]; eax = (a+b)/(c-2)-d = -20-10 = -30
        add eax , 2  ; eax = (a+b)/(c-2)-d+2 = -30+2 = -28
        cdq          ; edx:eax = eax = (a+b)/(c-2)-d+2 = -28
        
        sub eax , [x] 
        sbb edx , [x+4];edx:eax = (a+b)/(c-2)-d+2-x = -28-12 = -40
        mov bl , [r]   ; bl = rest = 0
         
        ;(a+b)/(c-2)-d+2-x = (-32-8)/(4-2) - 10 + 2 -  = -40/2 -10+2- = -30 + 2 - 12 = -40
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
