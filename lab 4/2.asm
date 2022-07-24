bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;Se dau cuvintele A si B. Se cere dublucuvantul C:
;bitii 0-3 ai lui C coincid cu bitii 5-8 ai lui B
;bitii 4-8 ai lui C coincid cu bitii 0-4 ai lui A
;bitii 9-15 ai lui C coincid cu bitii 6-12 ai lui A
;bitii 16-31 ai lui C coincid cu bitii lui B

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;    0000 0000 0000 0000
    A dw 1100101001011110b ; = CA5Eh
    B dw 0111011010010000b ; = 7690h
    C resd 1 

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ax , [A] ; ax = A = CA5Eh
        and ax , 1111100000000000b ; ax = 1100100000000000b = C800h
        shr ax , 11 ; ax = 01 1001b = 19h
        cwde        ; eax = ax = 01 1001b = 19h
        mov ebx , 0 ; ebx = 0h
        or ebx , eax;ebx = 01 1001b = 19h
        
        or ebx , 0111111100000b ; eax = 0 1111 1111 1001b = 0FF9h
        
        mov eax , 0  ; eax = 0
        mov ax , [B] ; eax = ax = b = 7690h = 0111011010010000b 
                     ; eax = 07690h
        and ax ,0111100000000b  ; ax = 0110 0000 0000b = 0600h
        cwde         ; eax = ax = 0110 0000 0000b = 0600h
        shl eax , 4  ; eax = 0110 0000 0000 0000b = 06000h
        or ebx , eax ; ebx = 0110 1111 1111 1001b = 06FF9h
        
        mov eax , 0  ; eax = 0 
        mov ax , [A] ; eax = ax = A = CA5Eh
                     ; eax = 0CA5Eh
        ;cwde         ; eax = ax = A = FFFFCA5Eh ,cele doua metode sunt echivalente
        shl eax , 16 ; eax = CA5E0000h
        or ebx , eax ; ebx =  CA5E 6FF9h
        
        mov dword[C] , ebx ; C = ebx = CA5E 6FF9h
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
