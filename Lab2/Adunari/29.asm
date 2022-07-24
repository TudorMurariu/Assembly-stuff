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
    a db 55
    b db 15
    c db 40
    d db 20

; our code starts here
segment code use32 class=code
    start:
        ; ...  (b+c)+(a+b-d)
        mov al , [b] ; al = b
        add al , [c] ; al = b+c
        mov bl , [a] ; bl = a
        add bl , [b] ; bl = a+b
        sub bl , [d] ; bl = a+b - d
        add al , bl  ; al = al + bl
        ;al = (15+40) + (55+15-20) = 55 + 50 = 105
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
