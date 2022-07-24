bits 32 
global citire, afisare
extern exit, scanf, printf, gets               
import exit msvcrt.dll    
import scanf msvcrt.dll  
import printf msvcrt.dll    
import gets msvcrt.dll   
 
segment code use32 class=code public 
    citire:   
        mov ebx , [esp+4]
        
        push dword ebx
        call [gets]
        add esp , 4
        
        ret
    
    afisare:
        mov eax , [esp+8]
        mov ebx , [esp+4]
        
        push dword eax 
        push dword ebx
        call [printf]
        add esp , 4*2
        
        ret