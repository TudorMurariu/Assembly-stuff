bits 32
global comp

segment code use32 class=code
    comp:
        mov eax , [esp+4]
        mov ebx , [esp+8]
        
        cmp eax , ebx
        jae x1
        mov eax , 0
        jmp end1
        
        x1:
        mov eax , 1
        end1:
        
        ret