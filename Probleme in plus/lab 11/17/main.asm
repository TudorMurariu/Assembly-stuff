bits 32
global start
extern exit,printf,fopen,fclose,fprintf,scanf
import exit msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import scanf msvcrt.dll
extern comp

segment data use32 class=data
    ;...
    max dd 0
    n dd 0
    x dd 0
    desc_f dd 0
    nume_fisier db "max.txt",0
    mod_aces db "w",0
    format_10 db "%d",0
    format_h db "%x",0
    
segment code use32 class=code
    start:
        ;...
    
        push dword n
        push dword format_10
        call [scanf]
        add esp , 4*2
        
        mov ecx , [n]
        loop_citire:
            push dword ecx
            
            push dword x
            push dword format_10
            call [scanf]
            add esp , 4*2
            
            push dword [max]
            push dword [x]
            call comp
            add esp , 4*2
            ; returneaza in eax 1 daca e mai mare x decat max
            
            cmp eax , 1
            jne continue
            
            ;else
            mov eax , [x]
            mov [max] , eax
            
            continue:
            pop ecx
        add esp , 4*2
        loop loop_citire
        
        ;fopen(nume_fisier,mod_aces) -> retureneaza desc_f
        push dword mod_aces
        push dword nume_fisier
        call [fopen]
        add esp , 4*2
        
        mov [desc_f] , eax
        cmp eax , 0
            je exittt
        
        push dword [max]
        push dword format_h
        push dword [desc_f]
        call [fprintf]
        add esp , 4*3
        
        ;fclose(desc_f)
        push dword [desc_f]
        call [fclose]
        add esp , 4*1
        
        exittt:    
        ; exit
        push dword 0
        call [exit]
        
        
   