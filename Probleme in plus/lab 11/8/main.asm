bits 32
global start
extern exit,printf
import exit msvcrt.dll
extern afis

segment data use32 class=data
    ; ...
    start1 dd 32
    finish1 dd 126
    aux dd 0
    
    
segment code use32 class=code
    start:
        ; ...
        mov ecx , [start1]
        
        loop1:
            mov ebx , ecx
            dec ebx
            cmp ebx , [finish1]
                je out1
            
            mov [aux] , ecx
            push dword ecx
            call afis
            add esp , 4*1
            
            mov ecx , [aux]
            inc ecx    
        jmp loop1
        out1:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit] 
        
        
    