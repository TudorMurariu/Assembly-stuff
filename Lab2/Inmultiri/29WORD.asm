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
    a db 2
    b db 80
    c db 5
    d db 3
    e dw 296
    f dw 2

; our code starts here
segment code use32 class=code
    start:
        ; ... [b*c-(e+f)]/(a+d)
        mov al , [b] ; al = b = 80
        mul byte[c]  ; ax = b*c = 400
        mov bx , [e] ; bx = e = 296
        add bx , [f] ; bx = e+f = 298
        sub ax , bx  ; ax = ax - bx = 400 - 298 = 102
        mov bl , [a] ; bl = a = 2
        add bl , [d] ; bl = a+d = 5
        mov bh , 0   ; bh = 0 si bx = a+d    (a,d sunt pe 1 byte)
        mov dx , 0   ; dx = 0
        
        div bx       ; dx:ax / bx = ax   si   dx:ax % bx = dx
        ;[b*c-(e+f)]/(a+d) = [400 - 298] / 5 = 102 / 5 
        ; ax = 20  si  dx = 3
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
