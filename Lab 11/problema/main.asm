bits 32 
global start         

extern exit, printf, scanf 
import exit msvcrt.dll 
import printf msvcrt.dll 
import scanf msvcrt.dll

extern concat1 

;Se dau doua siruri continand caractere. Sa se calculeze si sa se afiseze rezultatul concatenarii tuturor ;caracterelor ;tip cifra zecimala din cel de-al doilea sir dupa cele din primul sir si invers, rezultatul ;concatenarii primului sir ;dupa al doilea.

segment data use32 class=data public 
    Sir1 times 100 db 0
    Sir2 times 100 db 0
    format db "%s",0 ; ne ajuta la cirirea sirurilor de caractere
    SirIesire1 times 200 db 0
    SirIesire2 times 200 db 0
    endl db 10,0
    
segment code use32 class=code public 
    start: 
        ; ...
        ; Citire
        
        ;scanf("%s", Sir1)
        push dword Sir1
        push dword format
        call [scanf] ; apelam scanf
        add esp, 4 * 2 
        
        ;scanf("%s", Sir2)
        push dword Sir2
        push dword format
        call [scanf] ; apelam scanf
        add esp, 4 * 2 
        
        ; concat1(Sir1,Sir2,SirIesire1)
        push dword SirIesire1
        push dword Sir2
        push dword Sir1
        call concat1
        add esp, 4 * 3 
        
        ; concat1(Sir1,Sir2,SirIesire2)
        push dword SirIesire2
        push dword Sir1
        push dword Sir2
        call concat1
        add esp, 4 * 3 
        
        ; printf(SirIesire1)
        push dword SirIesire1
        call [printf]
        add esp, 4
        
        ; printf(endl)
        push dword endl
        call [printf]
        add esp, 4
        
        ; printf(SirIesire2)
        push dword SirIesire2
        call [printf]
        add esp, 4

        push dword 0  
        call [exit] 