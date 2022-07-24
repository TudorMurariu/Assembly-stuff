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
    a db 50
    b db 33
    c db 14
    d db 32
; our code starts here
segment code use32 class=code
    start:
        ; ...  (b+b)+(c-a)+d
        mov al , [b] ; ah = b
        add al , [b] ; ah = b+b
        mov bl , [c] ; bh = c
        sub bl , [a] ; bh = c - a
        add al , bl  ; ah = b+b + c-a
        add al ,[d]  ; ah = b+b + c-a + d
        ; 33 + 33 + 14 - 50 + 32 = 62
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
