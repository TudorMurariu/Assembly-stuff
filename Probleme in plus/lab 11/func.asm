bits 32 

global base_10_to_16

segment code use32 class=code
    base_10_to_16:
            mov eax , [esp + 4]
            mov edi , [esp + 8]
            
            mov ecx , 0
            loop1:
                mov dx , 0
                cmp eax , 16
                jb out1
                
                mov bx , 16
                div bx ; ax = dx:ax / bx , dx e restul
                
                cmp dx , 9
                    ja litera
                ;else (cifra)
                mov bx , ax
                mov al , dl
                add al , '0'
                stosb ; edi = al , edi++
                jmp continue
                
                litera:
                mov bx , ax
                mov al , dl
                add al , 'A'
                sub al , 10
                stosb ; edi = al , edi++
            
                continue:
                mov ax , bx
                inc ecx
            jmp loop1
            
            out1:
                cmp al , 10
                    jb cifra
                add al , 'A'
                sub al , 10
                jmp else1
                
                cifra:
                add al , '0'
                
                else1:
                stosb ; edi = al , edi++
                inc ecx
                mov eax , ecx
            
            ret