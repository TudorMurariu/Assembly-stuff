bits 32
global _concat
segment data public data use32
segment code public code use32
    _concat:
        mov esi , [esp+8] ; al 2-lea sir
        mov edi , [esp+12] ; al 3-lea sir (sirul destinatie)
        ; trecem prin toate elementele din al 2-lea sir
        ; si adaugam doar cifrele in sirul destinatie
        loop1: 
            lodsb ; al = [edi] , inc edi
            cmp al , 0
                je out1
            ; verificam daca in al este o cifra (caracter)
            cmp al , '0' 
                jl continue1
            cmp al , '9'
                jg continue1
            stosb ; [esi] = al , inc esi
            
            continue1:
        jmp loop1
        out1:
        
        mov esi , [esp+4] ; primul sir
        ; trecem prin toate elementele din primul sir
        ; si adaugam doar cifrele in sirul destinatie
        loop2:
            lodsb ; al = [edi] , inc edi
            cmp al , 0
                je out2
            ; verificam daca in al este o cifra(caracter)
            cmp al , '0'
                jl continue2
            cmp al , '9'
                jg continue2
            stosb ; [esi] = al , inc esi
            
            continue2:
        jmp loop2
        out2:
        
        ret 