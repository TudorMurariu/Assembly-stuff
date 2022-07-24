bits 32 
global concat1 
 
segment code use32 class=code public 
    concat1:    
        mov esi , [esp + 4]
        mov edi , [esp + 12]
        
        repeta:
            LODSB ; al = [esi] , esi++
            ; Verificam daca in al avem o cifra:
            cmp al , '0'
                jge and1
                jmp continue
            and1:
            cmp al , '9'
            jg continue
                ; daca avem in al o cifra atunci o adaugam in SirIesire1
                STOSB ; edi = al , edi++
                
            continue:
            cmp al , 0
            je outside
        jmp repeta
        outside:
        
        mov esi , [esp + 8]
        
        repeta2:
            LODSB ; al = [esi] , esi++
            ; Verificam daca in al avem o cifra:
            cmp al , '0'
                jge and2
                jmp continue2
            and2:
            cmp al , '9'
            jg continue2
            ; daca avem in al o cifra atunci o adaugam in SirIesire1
            STOSB ; edi = al , edi++
            continue2:
            cmp al , 0
            je outside2
        jmp repeta2
        outside2: 
        
        ret
        