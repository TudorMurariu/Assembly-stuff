bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf               
import exit msvcrt.dll    

import scanf msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 010101b
    b db 011101b
    c dd 0
    format db "%x",10,0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov eax , [c]
        or eax , 0FFFF0000h
        
        mov bx , 0
        mov bl , [b]
        and bl , 01111000b
        shr bx , 3
        and al , 0h
        or al , bl
        
        mov [c] , eax
        
        push dword [c]
        push dword format
        call [printf]
        add esp , 4*2
        
        mov eax , [c]
        or ax , 011000000000b
        
        mov ebx , 0
        mov bl , [a]
        and bl , 011111b
        shl ebx , 11
        or eax , ebx
        
        mov [c] , eax
        
        push dword [c]
        push dword format
        call [printf]
        add esp , 4*2
        
        mov ebx , 0
        mov bl , [a]
        push dword ebx
        push dword format
        call [printf]
        add esp , 4*2

        mov ebx , 0
        mov bl , [b]
        push dword ebx
        push dword format
        call [printf]
        add esp , 4*2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
