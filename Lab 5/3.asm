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
    S1 db 1, 2, 3, 4
    lung1 equ $-S1 ; lung1 = lungimea sirului S1
    S2 db 5, 6, 7
    lung2 equ $-S2 ; lung2 = lungimea sirului S2
    D times lung1+lung2 db 0 ; rezervam memorie(egala cu memoria ambelor siruri combinate) pentru D

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx , lung1 ; ecx = lung1
        mov esi , 0 ; un fel de pointer pentru S1
        mov edi , 0 ; un fel de pointer pentru D
        
        Repeta1:
            mov al , [S1 + esi] ; al = S1[esi]
            mov [D + edi], al   ; D[edi] = al
            inc edi ;edi++
            inc esi ;esi++
        loop Repeta1
        
        ; sirul D devine :  1,2,3,4
        
        ; vom parcugre sirul S2 descrescator
        mov esi , lung2-1 ; un fel de pointer pentru S2
        mov ecx , lung2 ; ecx = lung2
        
        
        Repeta2:
            mov al , [S2 + esi] ; al = S2[esi]
            mov [D + edi], al   ; D[edi] = al
            inc edi ;edi++
            dec esi ;esi--
        loop Repeta2
        
        ; sirul D devine :  1,2,3,4,7,6,5
        
        ; exit(0)
        ;push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
