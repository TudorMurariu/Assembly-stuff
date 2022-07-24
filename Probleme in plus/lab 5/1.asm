bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf,scanf             
import exit msvcrt.dll    
import printf msvcrt.dll    
import scanf msvcrt.dll    

segment data use32 class=data
    ; ...
    S db 1, 2, 3, 4, 5
    l equ $-S 
    D times l-1 dw 0
    format db "%d ",0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi , S
        mov edi , D
        mov ecx , 0
        
        lodsb ;al = esi , inc esi
        mov bl , al
        
        loop1:
            cmp ecx , l-1
            je out1
            
            lodsb ;al = [esi] , inc esi
            mov dl , al
            mul bl ; ax = al*bl
            stosw ; [edi] = ax  edi+=2
            
            mov bl , dl
            
            inc ecx
        jmp loop1
        out1:
        
        mov esi , D
        mov ecx , 0
        
        loop_afis:
            cmp ecx , l-1
            je out2
            
            mov eax , 0
            lodsw ; ax = [esi] esi+=2
            
            push ecx
            push esi
            
            push dword eax
            push dword format
            call [printf]
            add esp,4*2
            
            pop esi
            pop ecx
            
            inc ecx
        jmp loop_afis
        out2:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
