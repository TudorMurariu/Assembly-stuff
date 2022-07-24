bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    S db  '+', '4', '2', 'a', '@', '3', '$', '*'  ; declararea sirului S
    ;      2B   34   32   61   40   33   24   2A   (in hexa)
    lung equ $-S  ; stabilirea lungimea sirului initial
    D times lung db 0   ; rezervam spatiu pentru sirul D
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx , lung
        mov esi , 0 ; un fel de pointer pentru S
        mov edi , 0 ; un fel de pointer pentru D
        
        Repeta:
            mov al, [S + esi] 
            cmp al , '0'                ; daca al < '0' : adauga
            jge elif1    ; daca caracterul este mai mare sau egal decat '0'
                         ; atunci mergem la umatorul pas
            
            adauga:      ; altfel il adaugam in D si iesim
            mov [D + edi], al
            inc edi
            jmp Exit
            
            elif1:
            cmp al , '9'
            jg  elif2   ; daca este mai mare decat 9 il testam din nou
            jmp Exit    ; altfel iesim deoarece stim ca este un numar
            
            elif2:
            cmp al , 'A' 
            jge elif3  ; daca este mai mare decat 'A' il testam din nou
            jmp adauga ; altfel stim ca caracterul se afla intre  '9'+1 si 'A'-1 deci il adaugam
            
            elif3:
            cmp al , 'Z'
            jg elif4  ; daca este mai mare deact Z il testam din nou
            jmp Exit  ; altfel iesim deoarece stim ca este o litera mare
            
            elif4:
            cmp al , 'a'
            jge elif5  ; daca este mai mare decat 'a' il testam din nou 
            jmp adauga ; altfel stim ca caracterul se afla intre  'Z'+1 si 'a'-1 deci il adaugam
            
            elif5:
            cmp al , 'z'
            jle Exit   ; daca este mai mic decat 'z' iesim
            jmp adauga ; ltfel stim ca caracterul este mai mare decat 'z' deci il adaugam
            
            Exit:
            inc esi
        loop Repeta ; dec ecx
        
        ; D devine : '+', '@', '$', '*'
        ;            2B   40   24   2A  (in hexa)
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
