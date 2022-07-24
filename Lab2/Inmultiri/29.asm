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
    a db 30
    b db 20
    c db 3
    d dw 200
    doi db 2

; our code starts here
segment code use32 class=code
    start:
        ; ...[d-(a+b)*2]/c
        mov al , [a] ; al = a = 30
        add al , [b] ; al = a + b = 50
        mul byte[doi]; ax = 2*(a+b) = 100
        mov bx , ax  ; bx = ax = 2*(a+b) = 100
        
        mov ax , [d] ;ax = d = 200
        sub ax , bx  ; ax = ax - bx = 100
        div byte[c]  ; al = ax / c = 33  si   ah = ax % c = 1
        
        ;al = 33
        ;dh = 1
        ;[d-(a+b)*2]/c = [200 - 50*2]/3 = 100/3
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
