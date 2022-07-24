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
    a dw 0111101001010111b ; 7A57h
    b db 01101001b         ;   69h

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ax , [a] ;ax = a = 0111101001010111b = 7A57h
        and ax , 0111100000000b ; ax = 0000 1010 0000 0000b = 0A00h
        shr ax , 8 ; ax = 01010b = Ah
        mov bl , [b] ; bl = b = 0110 1001b = 69h
        and bl , 11110000b ;bl = 0110 0000b = 60h
        or bl , al ; bl =0110 1010 = 6Ah
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
