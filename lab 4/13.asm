bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;Dandu-se 4 octeti, sa se obtina in AX suma numerelor intregi reprezentate de bitii 4-6 ai celor 4 octeti.
                          
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ... ///
    a db 00101010b ; = 2Ah
    b db 01110010b ; = 72h
    c db 10001001b ; = 89h
    d db 10110111b ; = B7h

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov al , [a] ; al = a = 00101010b = 2Ah
        and al , 01110000b ; al = 0010 0000b = 20h
        shr al , 4 ; al = 010b = 02h
        
        mov bl , [b] ; bl = b = 72h
        and bl , 01110000b ; bl = 0111 0000b = 70h
        shr bl , 4 ; bl = 07h = 0111b
        add al , bl ; al = al + bl = 01001b = 09h
        
        mov bl , [c] ; bl = c = 89h
        and bl , 01110000b ; bl = 0000 0000b = 0h
        shr bl , 4 ; bl = 0h = 0b
        add al , bl ; al = al + bl = 01001b = 09h
        
        mov bl , [d] ; bl = b = B7h
        and bl , 01110000b ; bl = 0011 0000b = 30h
        shr bl , 4 ; bl = 03h = 0011b
        add al , bl ; al = al + bl = 01100b = 0Ch
        mov ah , 0  ; ax = al
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
