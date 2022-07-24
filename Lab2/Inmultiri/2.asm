bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ... a,b,c - byte, d - word
    a db 2
    b db 2
    c db 5
    d dw 8
    doi db 2

; our code starts here
segment code use32 class=code
    start:
        ; ... d*(d+2*a)/(b*c)
        ; b * c
        mov al , [b] ; al = b
        mul byte[c]  ; ax = b*c
        mov bx , ax  ; bx = ax = b*c
        ; d*(d+2*a)
        mov al , [a] ; al = a
        mul byte[doi]; ax = 2*a
        add ax , [d] ; ax = ax + d 
        mul word[d]  ; dx:ax = ax * d
        
        
        div bx ; ax = dx:ax  /   bx     ,  dx = dx:ax  %   bx 
        ; d*(d+2*a)/(b*c) = 8*(8+4) / (10) = (8*12)/10 = 96 / 10
        ;ax = 9
        ;dx = 6
        ; rezultatul calculului este 9 rest 6
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
