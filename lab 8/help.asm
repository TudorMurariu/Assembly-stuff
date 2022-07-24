bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    text db "22 3 5 200 77 700",10,0
    linie_noua db 10,0
    format db "%d",0
    x dw 0fffdh
; our code starts here
segment code use32 class=code
    start:
        ; ...
        add byte[x],2
        mov ax , [x]
       
        
        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
