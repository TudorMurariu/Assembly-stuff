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
    aux times 4 db 0
    S dw 1432h, 8675h, 0ADBCh, 0511h
    S_len equ ($-S)/2 ; S_len = lungimea sirului S in cuvinte
    new_S times S_len dd 0 ; rezervam memorie
    i resb 1
    ok db 1
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx , S_len
        mov esi , S + S_len*2 - 2    ; un fel de pointer pt S
        mov edi , new_S + S_len*4 - 4 ; un fel de pointer pt new_S       
                      
        
        Repeta:
            cmp ecx , 0
            jz sfarfit
            
            mov eax , 0
            std     ; DF = 1 
            LODSW   ; mov ax , [esi]    ,   sub esi , 2                                 
            
            
            ; creem un sir cu toate cifrele din hexa ale numarului din ax
            ; pentru a le putea sorta mai tarziu
            
            push ecx
            push esi
            mov ecx , 4
            mov esi , aux
            repeta_creare_vector:  
                mov bx , ax     
                and bx , 0Fh
                mov [esi] , bl
                shr ax , 4
                inc esi   ; esi++
            loop repeta_creare_vector
            pop esi
            pop ecx
            
            
            
            ;;;;;;;;; sortare 
            push ecx
            push esi
            mov byte[ok] , 1
            repeta_sortare:
                cmp byte[ok] , 0
                jz afara
                
                mov  byte[ok] , 0
                mov esi , aux
                mov ecx , 3   ; sirul are 4 numere 
                Repeta_sir:
                    mov al , [esi] 
                    cmp al , [esi + 1] 
                    jg swap 
                    jmp altfel
                    
                    swap:
                        mov bl , [esi + 1]
                        mov [esi] , bl 
                        mov [esi + 1] , al
                        mov  byte[ok] , 1
                    
                    altfel:
                    inc esi
                loop Repeta_sir
                
            jmp repeta_sortare
            
            afara:        
            pop esi
            pop ecx
            
            ;;;;; aducem din sir in ax numerele
            push ecx
            push esi
            mov ecx , 4
            mov bx , 0
            mov ax , 0
            mov esi , aux
            repeta_numar_nou:
                shl bx , 4
                cld   ; DF = 0                                     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                LODSB  ; al = [esi]   , esi++                     
                or bx , ax
            loop repeta_numar_nou
            
            mov ax , bx
            pop esi
            pop ecx
            
            
            ;;;;;;;; adaugam element in sirul new_S dupa cerinta    
            
            mov bx , ax
            mov eax , 0 ; clear eax
            
            push ecx
            mov ecx , 4
            mov byte[i] , 0
            
            Repeta1:
                mov edx , 0 ; clear edx
                mov dx , bx ; dx = bx 
                and dx , 0Fh; extragem ultimii 4 biti din bx
                
                push ecx
                mov cl , [i]
                shl edx , cl
                pop ecx
                or eax , edx
                 
                shr bx , 4
                add byte[i] , 8
            loop Repeta1
            
            ;cld   ; DF = 0
            std     ; DF = 1
            STOSD ; mov edi , eax   ,  sub edi , 4
            pop ecx
            
        jmp Repeta
        
        sfarfit:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
